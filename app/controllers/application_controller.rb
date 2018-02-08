class ApplicationController < ActionController::API

  private

  def data_wrapper(value)
    {
      'data' => value
    }
  end
end
