class HomeController < ApplicationController

  def index
    render json: {
      succes: true
    }
  end

end
