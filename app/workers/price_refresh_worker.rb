class PriceRefreshWorker
  include Sidekiq::Worker

  def perform(*args)
    ::Generators::Providers::CoinMarketCap.refresh
  end
end
