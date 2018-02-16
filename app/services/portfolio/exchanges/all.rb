# ::Portfolio::Exchanges::All
module Portfolio
  module Exchanges
    class All
      class << self

        def fetch_exchange_holdings(user_id) # string
          Rails.cache.fetch(cache_key(user_id)) do
            cache_exchange_holdings(user_id)
          end
        end

        def cache_exchange_holdings(user_id) # string
          holdings = {
            'total' => {}
          }
          api_keys(user_id).each do |api_key|
            exchange_holding = ::Portfolio::Exchanges::Single.fetch_exchange_holding(
              api_key
            )
            holdings["#{api_key.provider}/#{api_key.key.first(10)}"] = exchange_holding
            add_holdings(holdings['total'], exchange_holding)
          end

          Rails.cache.write(cache_key(user_id), holdings) && holdings
        end

        def clear_exchange_holdings(user_id) # string
          Rails.cache.delete(cache_key(user_id))
        end

        def cache_key(user_id) # string
          "portfolio/exchanges/#{user_id}"
        end

        private

        def api_keys(user_id) # string
          ::ApiKey.where(user_id: user_id)
        end

        def add_holdings(holdings, exchange_holdings) # hash, hash
          exchange_holdings.map do |sym, amount|
            if holdings[sym].present?
              holdings[sym] += amount
            else
              holdings[sym] = amount
            end
          end
        end

      end
    end
  end
end
