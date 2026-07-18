class V1::RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]

  skip_before_action :authenticate

  def create
    user = User.new(user_params)
    if user.save
      start_new_session_for user
      render json: { token: Current.session.token, user: user.as_json }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_content
    end
  rescue ActiveRecord::RecordNotUnique => e
    render json: { error: ["There was a problem creating your account"] }, status: :unprocessable_content
  end

  private

  def user_params
    params.permit(:name, :email_address, :password, :password_confirmation)
  end
end
