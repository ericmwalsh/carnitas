class PriceRefreshWorker
  include Sidekiq::Worker

  def perform(*args)
    ::ApiIntegrations::CoinMarketCap.refresh
  end
end
