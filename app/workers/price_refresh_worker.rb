class PriceRefreshWorker
  include Sidekiq::Worker

  def perform(*args)
    ::ExchangeWrapper::Temp::CoinMarketCap.refresh
  end
end
