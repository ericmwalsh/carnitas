Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(username),
      ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])
    ) & ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(password),
      ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"])
    )
  end if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"


  root :to => 'home#index'

  get 'aggregate_month' => 'old_portfolio#aggregate_month'
  post 'calculate' => 'old_portfolio#calculate'
  post 'calculate_week' => 'old_portfolio#calculate_week'
  post 'calculate_month' => 'old_portfolio#calculate_month'
  get 'cmc_cache' => 'old_portfolio#cmc_cache'

  get 'portfolio' => 'crypto_portfolio#index'
  post 'portfolio' => 'crypto_portfolio#create_or_update'
  # put 'portfolio' => 'crypto_portfolio#update'

  get 'api_keys' => 'api_keys#index'
  post 'api_keys' => 'api_keys#create'
  put 'api_keys' => 'api_keys#update'
  delete 'api_keys' => 'api_keys#delete'

  get 'inputs' => 'inputs#index'
  post 'inputs' => 'inputs#create'
  put 'inputs' => 'inputs#update'
  delete 'inputs' => 'inputs#delete'

  get 'new_portfolio' => 'portfolio#aggregate'
  get 'new_portfolio/exchanges' => 'portfolio#exchanges'
  put 'new_portfolio/exchanges/refresh' => 'portfolio#exchanges_refresh'
  get 'new_portfolio/inputs' => 'portfolio#inputs'

  get 'test' => 'home#hello_world'

end
