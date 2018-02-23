# ::Portfolio::ApiKeys::ClearHoldingsWorker
module Portfolio
  module ApiKeys
    class ClearHoldingsWorker
      include Sidekiq::Worker

      def perform(user_id, cache_key) # string, string
        handle_exceptions do
          ::Portfolio::Exchanges::Single.clear_exchange_holding(cache_key)
          ::Portfolio::Exchanges::All.cache_exchange_holdings(user_id)
          holdings = ::Portfolio::Aggregate.cache_aggregate_holdings(user_id)
          push_holdings_to_user(user_id, holdings)
        end
      end

    end
  end
end
