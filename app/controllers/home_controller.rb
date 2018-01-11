class HomeController < ApplicationController

  def index
    render json: {
      succes: true,
      last_updated: Snapshot.
                      where('cmc_last_updated IS NOT NULL').
                      order(cmc_last_updated: :desc).
                      select(:cmc_last_updated).
                      first.
                      cmc_last_updated
    }
  end

  # backup cached version of the most recent cmc
  # api response for when it fails to respond (FE app)
  def cmc_cache
    render json: ::Generators::Providers::CoinMarketCap.snapshot
  end
end
