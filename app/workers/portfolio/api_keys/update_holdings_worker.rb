# ::Portfolio::ApiKeys::UpdateHoldingsWorker
module Portfolio
  module ApiKeys
    class UpdateHoldingsWorker < ::Portfolio::ApiKeys::BaseWorker

      def perform(api_key_id) # integer
        handle_exceptions do
          api_key = ::ApiKey.find_by_id(api_key_id)
          ::Portfolio::Exchanges::Single.cache_exchange_holding(api_key)
          ::Portfolio::Exchanges::All.cache_exchange_holdings(api_key.user_id)
          ::Portfolio::Aggregate.cache_aggregate_holdings(api_key.user_id)
        end
      end

    end
  end
end
