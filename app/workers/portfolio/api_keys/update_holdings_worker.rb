# ::Portfolio::ApiKeys::UpdateHoldingsWorker
module Portfolio
  module ApiKeys
    class UpdateHoldingsWorker < ::Portfolio::ApiKeys::BaseWorker

      def perform(user_id, api_key_id) # string, integer
        handle_exceptions do
          api_key = ::ApiKey.find_by_id(api_key_id)
          ::Portfolio::Exchanges::Single.cache_exchange_holding(api_key)
          ::Portfolio::Exchanges::All.cache_exchange_holdings(api_key.user_id)
          holdings = ::Portfolio::Aggregate.cache_aggregate_holdings(api_key.user_id)
          push_holdings_to_user(user_id, holdings)
        end
      end

    end
  end
end
