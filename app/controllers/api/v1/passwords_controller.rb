class Api::V1::PasswordsController < ApplicationController
  def forgot
    if params[:email].blank?
      return render json: {error: 'Email not present' }
    end

    @user = user_type&.find_by(email: params[:email])

    if @user.present?
      @user.generate_password_token! #generate pass token
      PasswordMailer.test_mailer(@user, user_type).deliver_now
      render json: @user
    else
      render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
    end
  end

  def reset
    token = params[:token].to_s

    @user = user_type&.find_by(reset_password_token: token)

    if @user.present? && @user.token_valid?
      if @user.reset_password!(params[:password])
        render json: {status: 'ok'}, status: :ok
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
    end
  end

  private

  def user_type
    params[:user_type].capitalize.constantize
  end
end
