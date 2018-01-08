module CryptoPortfolioServices
  class Index
    class << self

      def run(user_id)
        ::CryptoPortfolio.find_by_user_id(user_id).try(:holdings) || ''
      end

    end
  end
end
