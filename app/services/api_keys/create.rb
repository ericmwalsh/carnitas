# ::ApiKeys::Create
module ApiKeys
  class Create
    class << self

      # api_key = {
      #   provider: 'binance',
      #   key: 'abc123',
      #   secret: 'zyx987'
      # }
      def run(user_id, api_key_params)
        new_key = ::ApiKey.create(
          api_key(user_id, api_key_params)
        )

        if new_key.errors.any?
          raise ::Exceptions::BadSaveError.new(new_key.errors.messages)
        else
          'success'
        end
      end

      private

      def api_key(user_id, api_key_params)
        encrypt_array = ::Utilities::Encryptor.encrypt(api_key_params[:secret])
        api_key_params.merge(
          user_id: user_id,
          encryptor: encrypt_array[0],
          secret: encrypt_array[1],
        )
      end

    end
  end
end
