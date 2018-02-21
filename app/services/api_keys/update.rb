# ::ApiKeys::Update
module ApiKeys
  class Update
    class << self

      # api_key = {
      #   provider: 'binance',
      #   key: 'abc123',
      #   secret: 'zyx987'
      # }
      def run(user_id, api_key_params)
        existing_key = ::ApiKey.find_by(
          user_id: user_id,
          key: api_key_params[:key]
        )

        if existing_key.present?
          existing_key.update(api_key(api_key_params))
        else
          raise ::Exceptions::NotFoundError.new('This api_key does not exist.')
        end

        if existing_key.errors.any?
          raise ::Exceptions::BadSaveError.new(existing_key.errors.messages)
        else
          'success'
        end
      end

      private

      def api_key(api_key_params)
        if api_key_params[:secret].present?
          encrypt_array = ::Utilities::Encryptor.encrypt(api_key_params[:secret])
          api_key_params.merge(
            encryptor: encrypt_array[0],
            secret: encrypt_array[1],
          )
        else
          api_key_params
        end
      end

    end
  end
end
