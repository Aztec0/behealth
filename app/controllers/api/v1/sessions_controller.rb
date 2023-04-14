# frozen_string_literal: true

class Api::V1::SessionsController < ApplicationController
  before_action :user
  def create
    @user = user.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      if @user.email_confirmed?
      token = JWT.encode({ user_id: @user.id, type: params[:user_type] }, Rails.application.secret_key_base)
      render json: { token: token }
      else
        render json: "Need to activate your account"
      end
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def user
    params[:user_type].capitalize.constantize
  end
end
