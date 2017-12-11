class PortfolioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def calculate
    result = ::PortfolioServices::Calculate.run(params['portfolio'].as_json)

    render json: result.merge(success: true)
  end
end
