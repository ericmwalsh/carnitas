# ::ApiIntegrations::Bittrex::AccountApi
module ApiIntegrations
  module Bittrex
    class AccountApi

      class << self

        def get_balances(api_key, secret_key)
          request(
            :get,
            'account/getbalances',
            api_key,
            secret_key
          )
        end

        private

        def request(method, url, api_key, secret_key, options = {})
          ::ApiIntegrations::Bittrex::Base.signed_request(
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
