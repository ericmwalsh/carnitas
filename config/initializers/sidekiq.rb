# Sidekiq.configure_server do |config|
#   config.periodic do |mgr|
#     # https://crontab.guru/

#     # mgr.register(cron_expression, worker_class, job_options={})

#     mgr.register('*/12 * * * *', CoinMarketCapWorker)
#   end
# end

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV['REDIS_URL'],
    size: 1
  }
end

Sidekiq.configure_server do |config|
  config.redis = {
    size: 2
  }
end


# Sidekiq::Cron::Job.create(
#   name: 'CoinMarketCap worker - every 12min',
#   cron: '*/12 * * * *',
#   class: 'CoinMarketCapWorker'
# )
