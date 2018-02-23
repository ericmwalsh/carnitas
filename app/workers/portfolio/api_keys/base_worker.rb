# ::Portfolio::ApiKeys::BaseWorker
module Portfolio
  module ApiKeys
    class BaseWorker
      include Sidekiq::Worker

      sidekiq_options :queue => 'apikey', :retry => 2

      private

      def handle_exceptions(&block) # block
        block.call
      rescue ::Exceptions::ApiRateLimitError => err
        # rate limit issue, reschedule in 3 mins
        self.sidekiq_retry_in_block = Proc.new do |count|
          180 # 3 minutes in seconds
        end
        puts 'api limit'
        puts err
        raise err
      rescue ::Exceptions::ApiUnknownError => err
        # request completed but result unknown
        # raise a rollbar notification (for posterity's sake)
        Rollbar.error(err)
        # doesn't raise the original err so it doesn't reschedule and accidentally duplicate the call
        puts 'api unknown'
        puts err
      end

      def push_holdings_to_user(user_id, holdings) # string, hash
        # https://github.com/pusher/pusher-http-node/issues/30#issuecomment-198354094
        user_holdings_pusher_key = "carnitas;portfolio;#{user_id.sub(/\|/, '-')}"

        Pusher.trigger(
          user_holdings_pusher_key,
          'update',
          holdings
        )
      end

    end
  end
end
