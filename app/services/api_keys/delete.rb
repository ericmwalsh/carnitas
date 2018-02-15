# ::ApiKeys::Delete
module ApiKeys
  class Delete
    class << self

      # api_key = {
      #   provider: 'binance',
      #   key: 'abc123',
      #   secret: 'zyx987'
      # }
      def run(user_id, api_key_params)
        key = api_key_params[:key]
        existing_key = ::ApiKey.find_by(
          user_id: user_id,
          key: key
        )

        if existing_key.present?
          existing_key.destroy
        else
          raise ::Exceptions::NotFoundError.new('This api_key does not exist.')
        end

        if existing_key.errors.any?
          raise ::Exceptions::BadSaveError.new(new_key.errors.messages)
        else
          'success'
        end
      end

    end
  end
end
