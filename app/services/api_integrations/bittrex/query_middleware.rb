# ::ApiIntegrations::Bittrex::QueryMiddleware
module ApiIntegrations
  module Bittrex
    class QueryMiddleware < ::ApiIntegrations::BaseMiddleware

      def initialize(app, api_key)
        super(app)
        @api_key = api_key
      end

      # Append api key to the query string and also generate
      # a timestamp in milliseconds and append to query string
      def call(env)
        # add api_key to URL
        env.url.query = add_query_param(
          env.url.query,
          'apikey',
          @api_key
        )

        # add nonce to URL
        env.url.query = add_query_param(
          env.url.query,
          'nonce',
          Time.now.to_i
        )

        @app.call env
      end

    end
  end
end
