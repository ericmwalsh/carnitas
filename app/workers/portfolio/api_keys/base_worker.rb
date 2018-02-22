# ::Portfolio::ApiKeys::BaseWorker
module Portfolio
  module ApiKeys
    class BaseWorker
      include Sidekiq::Worker

      sidekiq_options :queue => 'apikey', :retry => 2

      def handle_exceptions(&block)
        block.call
      rescue ::Exceptions::ApiRateLimitError => err
        # rate limit issue, reschedule in 3 mins
        # self.class.perform_in
        puts 'api limit'
        puts err
      rescue ::Exceptions::ApiUnknownError => err
        # request completed but result unknown
        Rollbar.error(err)
        puts 'api unknown'
        puts err
      end

    end
  end
end
