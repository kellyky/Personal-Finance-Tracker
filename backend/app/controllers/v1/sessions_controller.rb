class V1::SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]

  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  skip_before_action :authenticate

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      token = Current.session.token
      expires_at = JsonWebToken.decode(token)[:exp]
      render json: { token:, expires_at: }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def destroy
    terminate_session
    render json: { message: "Logged out" }, status: :ok
  end
end
