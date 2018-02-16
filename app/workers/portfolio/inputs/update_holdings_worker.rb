# ::Portfolio::Inputs::UpdateHoldingsWorker
module Portfolio
  module Inputs
    class UpdateHoldingsWorker
      include Sidekiq::Worker

      def perform(user_id) # string
        ::Portfolio::Inputs::All.cache_input_holdings(user_id)
      end

    end
  end
end
