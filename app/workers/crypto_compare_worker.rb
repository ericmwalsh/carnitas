class CryptoCompareWorker
  include Sidekiq::Worker

  def perform(*args)
    ::Generators::CcSnapshot.run
  end
end
