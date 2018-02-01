# ::ApiIntegrations::Binance::TimestampMiddleware
module ApiIntegrations
  module Binance
    class TimestampMiddleware < ::ApiIntegrations::BaseMiddleware

      # Generate a timestamp in milliseconds and append to query string
      def call(env)
        env.url.query = add_query_param(
          env.url.query,
          'timestamp',
          DateTime.now.strftime('%Q')
        )

        @app.call env
      end

    end
  end
end
