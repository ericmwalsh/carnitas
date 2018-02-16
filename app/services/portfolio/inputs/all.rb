# ::Portfolio::Inputs::All
module Portfolio
  module Inputs
    class All
      class << self

        def fetch_input_holdings(user_id) # string
          Rails.cache.fetch(cache_key(user_id)) do
            cache_input_holdings(user_id)
          end
        end

        def cache_input_holdings(user_id) # string
          holdings = {
            'total' => {}
          }
          inputs(user_id).each do |input|
            holdings['total'][input.symbol] = input.amount
          end

          Rails.cache.write(cache_key(user_id), holdings) && holdings
        end

        def clear_input_holdings(user_id) # string
          Rails.cache.delete(cache_key(user_id))
        end

        def cache_key(user_id) # string
          "portfolio/inputs/#{user_id}"
        end

        private

        def inputs(user_id) # string
          ::Input.where(user_id: user_id)
        end

      end
    end
  end
end
