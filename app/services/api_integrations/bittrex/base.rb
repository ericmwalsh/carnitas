# ::ApiIntegrations::Bittrex::Base
module ApiIntegrations
  module Bittrex
    class Base
      BASE_URL = ENV['BITTREX_URI']
      DEFAULT_ADAPTER = Faraday.default_adapter

      class << self

        def public_request(method, url, options = {})
          request(
            public_client,
            method,
            url,
            options
          )
        end

        def signed_request(method, url, api_key, secret_key, options = {})
          request(
            signed_client(api_key, secret_key),
            method,
            url,
            options
          )
        end

        private

        def request(client, method, url, options = {})
          if requests_disabled?
            raise ::Exceptions::ApiRateLimitError
          else
            response = client.send(method) do |req|
              req.url url
              req.params.merge! options
            end
            intercept_errors(response.status, response.body)
            response.body
          end
        end

        def intercept_errors(status, body) # integer, hash
          case status
          when 200
            unless body['success']
              message = body['message']
              case
              # {"success"=>false, "message"=>"APIKEY_INVALID", "result"=>nil}
              # {"success"=>false, "message"=>"INVALID_SIGNATURE", "result"=>nil}
              when ['APIKEY_INVALID', 'INVALID_SIGNATURE'].include?(message)
                raise ::Exceptions::BittrexApiInputError.new(body, status)
              when message =~ /RATE|LIMIT/
                disable_requests
                raise ::Exceptions::BittrexApiRateLimitError.new(body, status)
              else # SERVER_ERROR
                raise ::Exceptions::BittrexApiServerError.new(body, status)
              end
            end
          when 418, 429
            disable_requests
            raise ::Exceptions::BittrexApiRateLimitError.new(body, status)
          when 400...500
            # user side
            raise ::Exceptions::BittrexApiInputError.new(body, status)
          when 504
            # message sent, status UNKNOWN
            raise ::Exceptions::BittrexApiUnknownError.new(body, status)
          when 500...600
            # bittrex error
            raise ::Exceptions::BittrexApiServerError.new(body, status)
          end
        end

        def disable_requests
          Rails.cache.fetch('bittrex-requests-disabled', expires_in: 3.minutes) do
            true
          end
        end

        def enable_requests
          Rails.cache.delete('bittrex-requests-disabled')
        end

        def requests_disabled?
          Rails.cache.read('bittrex-requests-disabled').present?
        end

        def public_client(adapter = DEFAULT_ADAPTER)
          Faraday.new(url: "#{BASE_URL}") do |conn|
            conn.request :json
            conn.response :json, content_type: /\bjson$/
            conn.adapter adapter
          end
        end

        def signed_client(api_key, secret_key, adapter = DEFAULT_ADAPTER)
          Faraday.new(url: "#{BASE_URL}") do |conn|
            conn.request :url_encoded
            conn.response :json, content_type: /\bjson$/
            conn.use ::ApiIntegrations::Bittrex::QueryMiddleware, api_key
            conn.use ::ApiIntegrations::Bittrex::SignatureMiddleware, secret_key
            conn.adapter adapter
          end
        end

      end
    end
  end
end
