class InputsController < ApplicationController
  include Secured # current_user

  # GET /inputs
  def index
    render json: data_wrapper(
      ::Inputs::Index.run(current_user)
    )
  end

  # POST /inputs
  def create
    render json: data_wrapper(
      ::Inputs::Create.run(current_user, input_params)
    )
  end

  # # PUT /inputs
  def update
    render json: data_wrapper(
      ::Inputs::Update.run(current_user, input_params)
    )
  end

  # DEL /inputs
  def delete
    render json: data_wrapper(
      ::Inputs::Delete.run(current_user, input_params)
    )
  end

  private

  def input_params
    # whitelist params
    params.require(:input).permit(:symbol, :amount)
  end

end
