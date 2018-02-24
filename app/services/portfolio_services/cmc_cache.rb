module PortfolioServices
  class CmcCache
    class << self

      def run
        ::ExchangeWrapper::Temp::CoinMarketCap.get_request
      end

    end
  end
end
