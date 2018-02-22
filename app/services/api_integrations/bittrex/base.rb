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
            if response.status == 429
              disable_requests
            end
            response.body
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
