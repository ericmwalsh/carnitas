# ::ApiIntegrations::Binance::Utils
module ApiIntegrations
  module Binance
    class Utils
      class << self

        def holdings(key, secret)
          ::ApiIntegrations::Binance::AccountApi.account_info(
            key,
            secret
          )
        end

      end
    end
  end
end
