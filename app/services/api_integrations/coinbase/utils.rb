# ::ApiIntegrations::Coinbase::Utils
module ApiIntegrations
  module Coinbase
    class Utils
      class << self

        def holdings(key, secret)
          holdings = {}
          ::ApiIntegrations::Coinbase::AccountApi.accounts(
            key,
            secret
          ).each do |currency|
            amount = currency['balance']['amount'].to_f
            if amount > 0.0
              holdings[currency['currency']] = amount
            end
          end

          holdings
        end

      end
    end
  end
end
