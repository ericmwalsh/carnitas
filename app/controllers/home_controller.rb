class HomeController < ApplicationController

  def index
    render json: {
      succes: true,
      last_updated: Snapshot.
                      order(cmc_last_updated: :desc).
                      select(:cmc_last_updated).
                      first.
                      cmc_last_updated
    }
  end
end
