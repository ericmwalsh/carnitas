# ::Portfolio::BaseWorker
module Portfolio
  class BaseWorker
    include Sidekiq::Worker

    private

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
