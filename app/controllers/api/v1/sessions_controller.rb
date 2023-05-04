# frozen_string_literal: true

class Api::V1::SessionsController < ApplicationController
  before_action :user, only: %i[create]
  skip_before_action :authenticate_request

  def create
    @user = user.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      if @user.email_confirmed?
        token = JWT.encode({ user_id: @user.id, type: params[:user_type] }, Rails.application.secret_key_base)
        render json: { token: token }, status: :ok
      else
        render json: { error: 'Need to activate your account. Try to re-register again on tha ' }, status: :unauthorized
      end
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def google_oauth2
    user_info = request.env['omniauth.auth'].info

    @user = user.find_or_initialize_by(email: user_info.email)

    @user.first_name = user_info.first_name
    @user.last_name = user_info.last_name

    if @user.save
      token = JWT.encode({ user_id: @user.id, type: params[:user_type] }, Rails.application.secret_key_base)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Could not create user' }, status: :unprocessable_entity
    end
  end

  private

  def user
    params[:user_type].capitalize.constantize
  end
end
