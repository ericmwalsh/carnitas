# ::Portfolio::Exchanges::Refresh
module Portfolio
  module Exchanges
    class Refresh
      class << self

        def run(user_id, key = nil, provider = nil) # string, string, string
          if key.present? && provider.present?
            api_key = ::ApiKey.find_by(
              user_id: user_id,
              key: key,
              provider: provider
            )
            if api_key.present?
              ::Portfolio::ApiKeys::UpdateHoldingsWorker.perform_async(api_key.id)
            else
              raise ::Exceptions::NotFoundError.new('This api_key does not exist.')
            end
          else
            ::Portfolio::ApiKeys::RefreshHoldingsWorker.perform_async(user_id)
          end
        end

      end
    end
  end
end
