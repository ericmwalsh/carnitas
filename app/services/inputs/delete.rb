# ::Inputs::Delete
module Inputs
  class Delete
    class << self

      # input = {
      #   symbol: 'BTC',
      #   amount: 3.21443332
      # }
      def run(user_id, input_params)
        symbol = input_params[:symbol]
        existing_input = ::Input.find_by(
          user_id: user_id,
          symbol: symbol
        )

        if existing_input.present?
          existing_input.destroy
        else
          raise ::Exceptions::NotFoundError.new('This input does not exist.')
        end

        if existing_input.errors.any?
          raise ::Exceptions::BadSaveError.new(existing_input.errors.messages)
        else
          'success'
        end
      end

    end
  end
end
