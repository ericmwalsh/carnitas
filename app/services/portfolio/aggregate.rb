# ::Portfolio::Aggregate
module Portfolio
  class Aggregate
    class << self

      def fetch_aggregate_holdings(user_id) # string
        Rails.cache.fetch(cache_key(user_id)) do
          cache_aggregate_holdings(user_id)
        end
      end

      def cache_aggregate_holdings(user_id) # string
        exchange_holdings = exchange_holdings(user_id)
        input_holdings = input_holdings(user_id)

        holdings = {
          'exchanges' => exchange_holdings,
          'inputs' => input_holdings,
          'total' => total_holdings(
            [
              exchange_holdings['total'],
              input_holdings['total']
            ]
          )
        }

        Rails.cache.write(cache_key(user_id), holdings) && holdings
      end

      def clear_aggregate_holdings(user_id) # string
        Rails.cache.delete(cache_key(user_id))
      end

      def cache_key(user_id) # string
        "portfolio/aggregate/#{user_id}"
      end

      private

      def exchange_holdings(user_id) # string
        ::Portfolio::Exchanges::All.fetch_exchange_holdings(user_id)
      end

      def input_holdings(user_id) # string
        ::Portfolio::Inputs::All.fetch_input_holdings(user_id)
      end

      def total_holdings(holdings_array) # array (of hashes)
        total_holdings = {}

        holdings_array.each do |holdings|
          holdings.map do |sym, amount|
            if total_holdings[sym].present?
              total_holdings[sym] += amount
            else
              total_holdings[sym] = amount
            end
          end
        end

        total_holdings
      end

    end
  end
end
