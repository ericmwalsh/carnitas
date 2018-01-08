class CryptoPortfolioController < ApplicationController
  include Secured

  # GET /portfolio
  def index
    result = {
      data: ::CryptoPortfolioServices::Index.run(current_user)
    }

    render json: result
  end

  # POST /portfolio
  def create_or_update
    result = {
      data: ::CryptoPortfolioServices::CreateOrUpdate.run(current_user, portfolio_params)
    }

    render json: result
  end

  # # PUT /portfolio
  # def update
  #   #
  # end

  private

  def portfolio_params
    # whitelist params
    params.require(:crypto_portfolio).permit(:holdings)
  end

end
