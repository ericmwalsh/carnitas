class CryptoCompareWorker
  include Sidekiq::Worker

  def perform(*args)
    ::Generators::CcSnapshot.run
    ::PortfolioServices::AggregateMonth.run
  end
end
