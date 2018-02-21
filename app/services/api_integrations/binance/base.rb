# ::ApiIntegrations::Binance::Base
# https://github.com/binance-exchange/binance-official-api-docs/blob/master/rest-api.md
module ApiIntegrations
  module Binance
    class Base
      BASE_URL = ENV['BINANCE_URI']
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

        def verified_request(method, url, api_key, options = {})
          request(
            verified_client(api_key),
            method,
            url,
            options
          )
        end

        def withdraw_request(method, url, api_key, secret_key, options = {})
          request(
            withdraw_client(api_key, secret_key),
            method,
            url,
            options
          )
        end

        private

        def request(client, method, url, options = {})
          if requests_disabled?
            raise ::Exceptions::RateLimitError
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
          when 418, 429
            disable_requests
            raise ::Exceptions::BinanceApiRateLimitError.new(body, status)
          when 400...500
            # user side
            raise ::Exceptions::BinanceApiInputError.new(body, status)
          when 504
            # message sent, status UNKNOWN
            raise ::Exceptions::BinanceApiUnknownError.new(body, status)
          when 500...600
            # binance error
            raise ::Exceptions::BinanceApiError.new(body, status)
          end
        end

        def disable_requests
          Rails.cache.fetch('binance-requests-disabled', expires_in: 3.minutes) do
            true
          end
        end

        def enable_requests
          Rails.cache.delete('binance-requests-disabled')
        end

        def requests_disabled?
          Rails.cache.read('binance-requests-disabled').present?
        end

        def public_client(adapter = DEFAULT_ADAPTER)
          Faraday.new(url: "#{BASE_URL}/api") do |conn|
            conn.request :json
            conn.response :json, content_type: /\bjson$/
            conn.adapter adapter
          end
        end

        def signed_client(api_key, secret_key, adapter = DEFAULT_ADAPTER)
          Faraday.new(url: "#{BASE_URL}/api") do |conn|
            conn.request :json
            conn.response :json, content_type: /\bjson$/
            conn.headers['X-MBX-APIKEY'] = api_key
            conn.use ::ApiIntegrations::Binance::TimestampMiddleware
            conn.use ::ApiIntegrations::Binance::SignatureMiddleware, secret_key
            conn.adapter adapter
          end
        end

        def verified_client(api_key, adapter = DEFAULT_ADAPTER)
          Faraday.new(url: "#{BASE_URL}/api") do |conn|
            conn.response :json, content_type: /\bjson$/
            conn.headers['X-MBX-APIKEY'] = api_key
            conn.adapter adapter
          end
        end

        def withdraw_client(api_key, secret_key, adapter = DEFAULT_ADAPTER)
          Faraday.new(url: "#{BASE_URL}/wapi") do |conn|
            conn.request :url_encoded
            conn.response :json, content_type: /\bjson$/
            conn.headers['X-MBX-APIKEY'] = api_key
            conn.use ::ApiIntegrations::Binance::TimestampMiddleware
            conn.use ::ApiIntegrations::Binance::SignatureMiddleware, secret_key
            conn.adapter adapter
          end
        end

      end
    end
  end
end
