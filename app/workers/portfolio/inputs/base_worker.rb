# ::Portfolio::Inputs::BaseWorker
module Portfolio
  module Inputs
    class BaseWorker < ::Portfolio::BaseWorker

      sidekiq_options :queue => 'input', :retry => 2

    end
  end
end
