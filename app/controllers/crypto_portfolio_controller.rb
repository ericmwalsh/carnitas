class CryptoPortfolioController < ApplicationController
  include Secured

  # GET /portfolio
  def index
    render json: data_wrapper(
      ::CryptoPortfolioServices::Index.run(current_user)
    )
  end

  # POST /portfolio
  def create_or_update
    render json: data_wrapper(
      ::CryptoPortfolioServices::CreateOrUpdate.run(current_user, portfolio_params)
    )
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
