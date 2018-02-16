# ::CryptoPortfolioServices::Convert
module CryptoPortfolioServices
  class Convert
    class << self

      def run
        ::CryptoPortfolio.all.each do |crypto_portfolio|
          Oj.load(crypto_portfolio.holdings).each do |holding_pair| # array
            # ["BTC",0.03307861]
            symbol = holding_pair[0]
            amount = holding_pair[1]

            ::Input.find_or_create_by(
              {
                user_id: crypto_portfolio.user_id,
                symbol: symbol,
                amount: amount
              }
            )
          end
        end
      end
    end
  end
end
