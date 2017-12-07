class CoinMarketCapWorker
  include Sidekiq::Worker

  def perform(*args)
    ::Generators::Currency.run
    ::Generators::Snapshot.run
  end
end
