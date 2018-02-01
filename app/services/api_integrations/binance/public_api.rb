# ::ApiIntegrations::Binance::PublicApi
module ApiIntegrations
  module Binance
    class PublicApi

      class << self

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

        private

        def request(method, url, options = {})
          ::ApiIntegrations::Binance::Base.public_request(
            method,
            url,
            options
          )
        end

      end
    end
  end
end
