class PortfolioController < ApplicationController
  def calculate
    result = ::PortfolioServices::Calculate.run(params['portfolio'].as_json)

    render json: result.merge(success: true)
  end

  def calculate_week
    result = ::PortfolioServices::CalculateDuration.run(7, params['portfolio'].as_json)

    render json: result.merge(success: true)
  end

  def calculate_month
    result = ::PortfolioServices::CalculateDuration.run(30, params['portfolio'].as_json)

    render json: result.merge(success: true)
  end
end
