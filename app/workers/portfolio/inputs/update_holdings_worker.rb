# ::Portfolio::Inputs::UpdateHoldingsWorker
module Portfolio
  module Inputs
    class UpdateHoldingsWorker < ::Portfolio::Inputs::BaseWorker

      def perform(user_id) # string
        ::Portfolio::Inputs::All.cache_input_holdings(user_id)
        ::Portfolio::Aggregate.cache_aggregate_holdings(user_id)
      end

    end
  end
end
