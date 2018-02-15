class PortfolioController < ApplicationController
  include Secured # current_user

  # GET /new_portfolio
  def aggregate
    render json: data_wrapper(
      ::Portfolio::Aggregate.run(current_user)
    )
  end

  # GET /new_portfolio/exchanges
  def exchanges
    render json: data_wrapper(
      ::Portfolio::Exchanges::All.fetch_exchange_holdings(
        current_user
      )
    )
  end

  # GET /new_portfolio/inputs
  def inputs
    render json: data_wrapper(
      ::Portfolio::Inputs.run(current_user)
    )
  end

  # # GET /new_portfolio/wallets
  # def wallets
  #   #
  # end

end
