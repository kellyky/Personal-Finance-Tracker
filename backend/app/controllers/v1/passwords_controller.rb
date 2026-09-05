class V1::PasswordsController < ApplicationController
  skip_before_action :authenticate, only: %i[create update]
  allow_unauthenticated_access only: %i[create update]     
  before_action :set_user_by_token, only: %i[update]

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
      render json: { message: 'Password reset instructions sent' }
    else
      render json: { message: 'User not found' }, status: :not_found
    end
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      @user.sessions.destroy_all
      render json: { message: 'Password has been reset.' }
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_password_reset_token!(params[:token])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    render json: { message: 'Password reset link is invalid or has expired.' },
      status: :unauthorized
  end
end
