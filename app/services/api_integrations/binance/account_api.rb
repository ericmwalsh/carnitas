# ::ApiIntegrations::Binance::AccountApi
module ApiIntegrations
  module Binance
    class AccountApi

      class << self

        def info(api_key, secret_key)
          request(
            :get,
            'v3/account',
            api_key,
            secret_key
          )
        end

        def trades_list(api_key, secret_key, symbol)
          request(
            :get,
            'v3/myTrades',
            api_key,
            secret_key,
            {
              symbol: symbol
            }
          )
        end

        private

        def request(method, url, api_key, secret_key, options = {})
          ::ApiIntegrations::Binance::Base.signed_request(
            method,
            url,
            api_key,
            secret_key,
            options
          )
        end

      end
    end
  end
end
