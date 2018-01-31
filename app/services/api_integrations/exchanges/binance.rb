# ::ApiIntegrations::Exchanges::Binance
module ApiIntegrations
  module Exchanges
    class Binance < ::ApiIntegrations::Exchanges::Base
      base_uri ENV['BINANCE_URI']

      class << self

        def ping
          request('/v1/ping')
        end

        def time
          request('/v1/time')
        end

        def exchange_info
          request('/v1/exchangeInfo')
        end

        # def account_information

        def holdings(params = {})
          raise ::NotImplementedError, 'implement this in your subclass'
        end

      end

    end
  end
end
