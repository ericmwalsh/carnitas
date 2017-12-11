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
    size: 5
  }
end

Sidekiq.configure_server do |config|
  config.redis = {
    size: 5
  }
end

unless Rails.env.production?
  Sidekiq::Cron::Job.create(
    name: 'CoinMarketCap worker - every 12min',
    cron: '*/5 * * * *',
    class: 'CoinMarketCapWorker'
  )
end
