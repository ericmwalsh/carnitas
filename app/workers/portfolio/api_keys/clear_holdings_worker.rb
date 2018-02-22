# ::Portfolio::ApiKeys::ClearHoldingsWorker
module Portfolio
  module ApiKeys
    class ClearHoldingsWorker
      include Sidekiq::Worker

      def perform(user_id, cache_key) # string, string
        handle_exceptions do
          ::Portfolio::Exchanges::Single.clear_exchange_holding(cache_key)
          ::Portfolio::Exchanges::All.cache_exchange_holdings(user_id)
          ::Portfolio::Aggregate.cache_aggregate_holdings(user_id)
        end
      end

    end
  end
end
