# ::Portfolio::Inputs::BaseWorker
module Portfolio
  module Inputs
    class BaseWorker
      include Sidekiq::Worker

      sidekiq_options :queue => 'input', :retry => 2
    end
  end
end
