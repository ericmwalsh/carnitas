Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'


  root :to => 'home#index'
  get 'cmc_cache' => 'home#cmc_cache'

  get 'aggregate_month' => 'portfolio#aggregate_month'
  post 'calculate' => 'portfolio#calculate'
  post 'calculate_week' => 'portfolio#calculate_week'
  post 'calculate_month' => 'portfolio#calculate_month'

  get 'portfolio' => 'crypto_portfolio#index'
  post 'portfolio' => 'crypto_portfolio#create_or_update'
  # put 'portfolio' => 'crypto_portfolio#update'

end
