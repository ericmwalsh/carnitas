# ::Portfolio::ApiKeys::BaseWorker
module Portfolio
  module ApiKeys
    class BaseWorker
      include Sidekiq::Worker

      sidekiq_options :queue => 'apikey', :retry => 2

      def handle_exceptions(&block)
        block.call
      rescue ::Exceptions::BinanceApiInputError => err
        #
        puts 'api input'
        puts err
      rescue ::Exceptions::BinanceApiUnknownError => err
        #
        puts 'api unknown'
        puts err
      end

    end
  end
end
