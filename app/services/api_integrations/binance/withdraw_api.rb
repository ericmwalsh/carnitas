# ::ApiIntegrations::Binance::WithdrawApi
module ApiIntegrations
  module Binance
    class WithdrawApi

      class << self

        def deposit_history(api_key, secret_key)
          request(
            :get,
            'v3/depositHistory.html',
            api_key,
            secret_key
          )
        end

        def withdraw_history(api_key, secret_key)
          request(
            :get,
            'v3/withdrawHistory.html',
            api_key,
            secret_key
          )
        end

        private

        def request(method, url, api_key, secret_key, options = {})
          ::ApiIntegrations::Binance::Base.withdraw_request(
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
