class ApplicationController < ActionController::API

  before_action :set_default_json_format

  rescue_from ::Exceptions::BaseError, with: :error_wraper

  private

  def set_default_json_format
    request.format = :json unless params[:format]
  end

  def data_wrapper(value)
    {
      'data' => value
    }
  end

  def error_wraper(exception)
    render json: {
      status: exception.status,
      error: exception.message
    },
    status: exception.status
  end
end
