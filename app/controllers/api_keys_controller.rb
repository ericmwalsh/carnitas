class ApiKeysController < ApplicationController
  include Secured # current_user

  # GET /api_keys
  def index
    render json: data_wrapper(
      ::ApiKeys::Index.run(current_user)
    )
  end

  # POST /api_keys
  def create
    render json: data_wrapper(
      ::ApiKeys::Create.run(current_user, api_key_params)
    )
  end

  # # PUT /api_keys
  def update
    render json: data_wrapper(
      ::ApiKeys::Update.run(current_user, api_key_params)
    )
  end

  # DEL /api_keys
  def delete
    render json: data_wrapper(
      ::ApiKeys::Delete.run(current_user)
    )
  end

  private

  def api_key_params
    # whitelist params
    params.require(:api_keys).permit(:user_id, :provider, :key, :secret)
  end

end
