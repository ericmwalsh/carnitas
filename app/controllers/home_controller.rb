class HomeController < ApplicationController

  def index
    render json: {
      succes: true
    }
  end

  def hello_world
    Pusher.trigger('my-channel', 'my-event', {
      message: 'hello world'
    })
  end

end
