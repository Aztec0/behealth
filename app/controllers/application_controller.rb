# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Pagy::Backend
  before_action :authenticate_request

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  
  def current_user
    @current_patient || @current_doctor
  end

  def authenticate_patient_user
    user_not_authorized unless current_user.is_a?(Patient)
  end

  def authenticate_doctor_user
    user_not_authorized unless current_user.is_a?(Doctor)
  end

  def user_not_authorized
    render_error('You are not authorized to perform this action', status: :forbidden)
  end

  def authenticate_request
    token = extract_token_from_header
    return render_error('Missing token', status: :unauthorized) unless token

    decoded_token = decode_token(token)
    return render_error('Invalid token', status: :unauthorized) unless decoded_token

    user = fetch_user_from_database(decoded_token)
    return render_error('Invalid token', status: :unauthorized) unless user

    set_current_user(user)
  end

  def extract_token_from_header
    auth_header = request.headers['Authorization']
    auth_header&.split(' ')&.last
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: ENV['JWT_SECRET']).first
  rescue JWT::DecodeError
    nil
  end

  def fetch_user_from_database(decoded_token)
    type = decoded_token['type']
    user_id = decoded_token['user_id']
    return nil unless %w[patient doctor].include?(type)

    type.capitalize.constantize.find_by(id: user_id)
  end

  # rubocop don't like names prefix 'set' here
  def set_current_user(user)
    if user.is_a?(Patient)
      @current_patient = user
    elsif user.is_a?(Doctor)
      @current_doctor = user
    end
  end

  def render_error(message, status: :not_found)
    render json: { error: message }, status: status
  end

  def render_success(message, status: :ok)
    render json: { data: message }, status: status
  end
end
