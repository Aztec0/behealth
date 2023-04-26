class ApplicationController < ActionController::API
  # before_action :authenticate_request

  private

  def authenticate_request
    token = extract_token_from_header
    return render_error('Missing token', :unauthorized) unless token

    decoded_token = decode_token(token)
    return render_error('Invalid token', :unauthorized) unless decoded_token

    user = fetch_user_from_database(decoded_token)
    return render_error('Invalid token', :unauthorized) unless user

    set_current_user(user)
  end

  def extract_token_from_header
    auth_header = request.headers['Authorization']
    auth_header&.split(' ')&.last
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256').first
  rescue JWT::DecodeError
    nil
  end

  def fetch_user_from_database(decoded_token)
    type = decoded_token['type']
    user_id = decoded_token['user_id']
    return nil unless %w[patient doctor].include?(type)

    type.capitalize.constantize.find_by(id: user_id)
  end

  def set_current_user(user)
    if user.is_a?(Patient)
      @current_patient = user
    elsif user.is_a?(Doctor)
      @current_doctor = user
    end
  end

  def render_error(message, status)
    render json: { error: message }, status: status
  end
end
