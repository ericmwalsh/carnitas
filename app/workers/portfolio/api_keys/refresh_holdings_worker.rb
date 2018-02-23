# ::Portfolio::ApiKeys::RefreshHoldingsWorker
module Portfolio
  module ApiKeys
    class RefreshHoldingsWorker < ::Portfolio::ApiKeys::BaseWorker

      def perform(user_id) # string
        handle_exceptions do
          api_keys = ::ApiKey.where(user_id: user_id)
          api_keys.each do |api_key|
            ::Portfolio::Exchanges::Single.cache_exchange_holding(api_key)
          end
          ::Portfolio::Exchanges::All.cache_exchange_holdings(user_id)
          holdings = ::Portfolio::Aggregate.cache_aggregate_holdings(user_id)
          push_holdings_to_user(user_id, holdings)
        end
      end

    end
  end
end
