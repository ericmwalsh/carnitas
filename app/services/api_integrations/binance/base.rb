# ::ApiIntegrations::Binance::Base
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

        # Internal: Append key-value pair to REST query string
        #
        # query - The String of the existing request query url.
        #
        # key   - The String that represents the param type.
        #
        # value - The String that represents the param value.
        def add_query_param(query, key, value)
          query = query.to_s
          query << '&' unless query.empty?
          query << "#{Faraday::Utils.escape key}=#{Faraday::Utils.escape value}"
        end

        private

        def request(client, method, url, options = {})
          response = client.send(method) do |req|
            req.url url
            req.params.merge! options
          end

          response.body
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
            conn.request :json
            conn.response :json, content_type: /\bjson$/
            conn.headers['X-MBX-APIKEY'] = api_key
            conn.use TimestampMiddleware
            conn.use SignatureMiddleware, secret_key
            conn.adapter adapter
          end
        end

        def verified_client(api_key, adapter = DEFAULT_ADAPTER)
          Faraday.new(url: "#{BASE_URL}") do |conn|
            conn.response :json, content_type: /\bjson$/
            conn.headers['X-MBX-APIKEY'] = api_key
            conn.adapter adapter
          end
        end

        # Generate a timestamp in milliseconds and append to query string
        TimestampMiddleware = Struct.new(:app) do
          def call(env)
            env.url.query = ::ApiIntegrations::Binance::Base.add_query_param(
              env.url.query,
              'timestamp',
              DateTime.now.strftime('%Q')
            )

            app.call env
          end
        end

        # Sign the query string using HMAC(sha-256) and appends to query string
        SignatureMiddleware = Struct.new(:app, :secret_key) do
          def call(env)
            value = OpenSSL::HMAC.hexdigest(
              OpenSSL::Digest.new('sha256'),
              secret_key,
              env.url.query
            )
            env.url.query = ::ApiIntegrations::Binance::Base.add_query_param(
              env.url.query,
              'signature',
              value
            )

            app.call env
          end
        end

      end
    end
  end
end
