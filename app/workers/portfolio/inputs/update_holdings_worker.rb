# ::Portfolio::Inputs::UpdateHoldingsWorker
module Portfolio
  module Inputs
    class UpdateHoldingsWorker < ::Portfolio::Inputs::BaseWorker

      def perform(user_id) # string
        ::Portfolio::Inputs::All.cache_input_holdings(user_id)
        holdings = ::Portfolio::Aggregate.cache_aggregate_holdings(user_id)
        push_holdings_to_user(user_id, holdings)
      end

    end
  end
end
