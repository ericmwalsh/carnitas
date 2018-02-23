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

          wrapped_holdings = {
            'success' => true,
            'message' => nil,
            'holdings' => holdings
          }

          # mark apikey as valid if previously marked invalid
          if !api_key.is_valid
            api_key.update_column(
              :is_valid,
              true
            )
          end

          Rails.cache.write(cache_key(api_key), wrapped_holdings) && wrapped_holdings
        rescue ::Exceptions::ApiInputError => err
          # raise a rollbar notification (for posterity's sake)
          Rollbar.error(err)
          # mark apikey as invalid if previously marked valid
          if api_key.is_valid
            api_key.update_column(
              :is_valid,
              false
            )
          end

          {
            'success' => false,
            'message' => 'Invalid API credentials',
            'holdings' => {}
          }
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
