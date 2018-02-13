module Portfolio
  class Exchanges
    class << self

      def run(user_id)
        holdings = {}
        api_keys(user_id).each do |api_key|
          add_holdings(holdings, api_key.holdings)
        end

        holdings
      end

      private

      def api_keys(user_id)
        ApiKey.where(user_id: user_id)
      end

      def add_holdings(holdings, exchange_holdings)
        exchange_holdings.map do |sym, amount|
          if holdings[sym].present?
            holdings[sym] += amount
          else
            holdings[sym] = amount
          end
        end
      end

    end
  end
end
