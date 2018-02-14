# ::ApiIntegrations::Gdax::Utils
module ApiIntegrations
  module Gdax
    class Utils
      class << self

        def holdings(key, secret, passphrase)
          holdings = {}
          ::ApiIntegrations::Gdax::AccountApi.accounts(
            key,
            secret,
            passphrase
          ).each do |currency|
            amount = currency['available'].to_f
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
