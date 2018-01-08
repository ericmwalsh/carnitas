# https://auth0.com/docs/quickstart/backend/rails/01-authorization

# frozen_string_literal: true
module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  private

  def current_user
    @current_user
  end

  def authenticate_request!
    @current_user ||= auth_token[0]['sub']
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def http_token
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    ::JsonWebToken::Base.verify(http_token)
  end
end
