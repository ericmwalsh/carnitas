module PortfolioServices
  class CmcCache
    class << self

      def run
        ::ApiIntegrations::CoinMarketCap.get_request
      end

    end
  end
end
