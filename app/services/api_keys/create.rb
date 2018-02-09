# ::ApiKeys::Create
module ApiKeys
  class Create
    class << self

      # api_key = {
      #   provider: 'binance',
      #   key: 'abc123',
      #   secret: 'zyx987'
      # }
      def run(user_id, api_key)
        new_key = ::ApiKey.create(
          api_key_params(user_id, api_key)
        )
        # byebug
        # NEED TO CATCH THE ERROR AND WRAP IT UP LIKE AN ERROR...
        if new_key
          'success'
        else
          'failure'
        end
      end

      private

      def api_key_params(user_id, api_key)
        api_key.merge(
          user_id: user_id,
          secret: ::Utilities::Encryptor.encrypt(api_key[:secret]),
          encryptor: ::Utilities::Encryptor.encryptor
        )
      end

    end
  end
end
