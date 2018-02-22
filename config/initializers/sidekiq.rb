# Sidekiq.configure_server do |config|
#   config.periodic do |mgr|
#     # https://crontab.guru/

#     # mgr.register(cron_expression, worker_class, job_options={})

#     mgr.register('*/12 * * * *', CoinMarketCapWorker)
#   end
# end

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV['REDIS_URL']
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV['REDIS_URL']
  }
end

Sidekiq::Cron::Job.create(
  name: 'PriceRefresh worker - every 1min',
  cron: '*/1 * * * *',
  class: 'PriceRefreshWorker'
)

# Sidekiq::Cron::Job.create(
#   name: 'CoinMarketCap worker - every 5min',
#   cron: '*/5 * * * *',
#   class: 'CoinMarketCapWorker'
# )

Sidekiq::Cron::Job.create(
  name: 'CryptoCompare worker - every day at 00:30',
  cron: '30 0 * * *',
  class: 'CryptoCompareWorker'
)
