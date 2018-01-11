class HomeController < ApplicationController

  def index
    render json: {
      succes: true
    }
  end

  # backup cached version of the most recent cmc
  # api response for when it fails to respond (FE app)
  def cmc_cache
    render json: ::Generators::Providers::CoinMarketCap.snapshot
  end
end
