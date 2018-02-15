# ::Inputs::Create
module Inputs
  class Create
    class << self

      # input = {
      #   symbol: 'BTC',
      #   amount: 3.21443332
      # }
      def run(user_id, input_params)
        new_input = ::Input.create(
          input(user_id, input_params)
        )

        if new_input.errors.any?
          raise ::Exceptions::BadSaveError.new(new_input.errors.messages)
        else
          'success'
        end
      end

      private

      def input(user_id, input_params)
        input_params.merge(
          user_id: user_id
        )
      end

    end
  end
end
