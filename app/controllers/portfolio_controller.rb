class PortfolioController < ApplicationController
  # include Secured

  def aggregate_month
    result = Rails.cache.fetch('::PortfolioServices::AggregateMonth.run', expires_in: 12.hours) do
      ::PortfolioServices::AggregateMonth.run.merge(success: true).to_json
    end
    render json: result
  end

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

  # GET /cmc_cache
  def cmc_cache
    result = ::PortfolioServices::CmcCache.run
    render json: result
  end
end
