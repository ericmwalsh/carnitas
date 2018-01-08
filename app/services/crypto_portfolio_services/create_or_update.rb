module CryptoPortfolioServices
  class CreateOrUpdate
    class << self

      def run(user_id, holdings)
        if crypto_portfolio = ::CryptoPortfolio.find_by_user_id(user_id)
          # update
          crypto_portfolio.update(holdings)
        else
          # create
          ::CryptoPortfolio.create(holdings.merge(user_id: user_id))
        end

        holdings
      end

    end
  end
end
