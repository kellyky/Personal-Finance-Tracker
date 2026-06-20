class V1::SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]

  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  skip_before_action :authenticate

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      render json: {
        data: {
          token: Current.session.token
        }
      }
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, status: :see_other
  end
end
