# ::ApiIntegrations::Binance::PublicApi
module ApiIntegrations
  module Binance
    class PublicApi

      class << self

        # MISC
        def ping
          request(
            :get,
            'v1/ping'
          )
        end

        def time
          request(
            :get,
            'v1/time'
          )
        end

        def exchange_info
          request(
            :get,
            'v1/exchangeInfo'
          )
        end

        # MARKET DATA
        def day_pricing
          request(
            :get,
            'v1/ticker/24hr'
          )
        end

        def trades(symbol, limit = 500)
          request(
            :get,
            'v1/trades',
            {
              symbol: symbol,
              limit: limit
            }
          )
        end

        # start_time and end_time have to be withn an hour
        def agg_trades(symbol, start_time, end_time, limit = 500)
          request(
            :get,
            'v1/aggTrades',
            {
              symbol: symbol,
              startTime: start_time,
              endTime: end_time,
              limit: limit
            }
          )
        end

        private

        def request(method, url, options = {})
          ::ApiIntegrations::Binance::Base.public_request(
            method,
            url,
            options
          )
        end

        def date_to_timestamp(date)
          if date.is_a?(Date)
            date.to_datetime
          elsif date.is_a?(String)
            DateTime.parse(date)
          # elsif date.is_a?(DateTime)
          else
            date
          end.strftime('%Q')
        end

      end
    end
  end
end
