# ::Portfolio::Exchanges::Single
module Portfolio
  module Exchanges
    class Single
      class << self

        def fetch_exchange_holding(api_key) # ApiKey model
          Rails.cache.fetch(cache_key(api_key)) do
            cache_exchange_holding(api_key)
          end
        end

        def cache_exchange_holding(api_key) # ApiKey model
          holdings = if api_key.gdax_provider?
            ::ApiIntegrations::Gdax::Utils.holdings(
              api_key.key,
              api_key.api_secret,
              api_key.passphrase
            )
          else
            "::ApiIntegrations::#{api_key.provider.capitalize}::Utils"
              .constantize
              .holdings(
                api_key.key,
                api_key.api_secret
              )
          end

          Rails.cache.write(cache_key(api_key), holdings) && holdings
        end

        def clear_exchange_holding(cache_key) # string
          Rails.cache.delete(cache_key)
        end

        def cache_key(api_key) # ApiKey model
          api_key.cache_key
        end

      end
    end
  end
end
