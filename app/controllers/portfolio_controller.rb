class PortfolioController < ApplicationController
  def calculate
    result = ::PortfolioServices::Calculate.run(params['portfolio'].as_json)

    render json: result.merge(success: true)
  end
end
