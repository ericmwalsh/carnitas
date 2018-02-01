# ::ApiIntegrations::Binance::SignatureMiddleware
module ApiIntegrations
  module Binance
    class SignatureMiddleware < ::ApiIntegrations::BaseMiddleware

      def initialize(app, secret_key)
        super(app)
        @secret_key = secret_key
      end

      # Sign the query string using HMAC(sha-256) and appends to query string
      def call(env)
        value = OpenSSL::HMAC.hexdigest(
          OpenSSL::Digest.new('sha256'),
          @secret_key,
          env.url.query
        )
        env.url.query = add_query_param(
          env.url.query,
          'signature',
          value
        )

        @app.call env
      end

    end
  end
end
