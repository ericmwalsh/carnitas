Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'


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
  get 'new_portfolio/inputs' => 'portfolio#inputs'

  get 'test' => 'home#hello_world'

end
