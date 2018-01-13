module PortfolioServices
  class CmcCache
    class << self

      def run
        ::Generators::Providers::CoinMarketCap.get_request
      end

    end
  end
end
