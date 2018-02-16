# ::Portfolio::ApiKeys::RefreshHoldingsWorker
module Portfolio
  module ApiKeys
    class RefreshHoldingsWorker
      include Sidekiq::Worker

      def perform(user_id) # string
        api_keys = ::ApiKey.where(user_id: user_id)
        api_keys.each do |api_key|
          ::Portfolio::Exchanges::Single.cache_exchange_holding(api_key)
        end
        ::Portfolio::Exchanges::All.cache_exchange_holdings(user_id)
        ::Portfolio::Aggregate.cache_aggregate_holdings(user_id)
      end

    end
  end
end
