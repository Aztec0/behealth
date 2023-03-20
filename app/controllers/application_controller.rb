class ApplicationController < ActionController::API
  def authenticate_request
    auth_header = request.headers['Authorization']
    if auth_header && auth_header.split(' ').last
      token = auth_header.split(' ').last
      begin
        decoded_token = JWT.decode(token, Rails.application.secret_key_base)
        user_id = decoded_token[0][params[:user_type]]
        if decoded_token[0]['type'] == "patient"
          if Patient.exists?(user_id)
            @current_patient = Patient.find(user_id)
          else
            render json: { error: 'Invalid token' }, status: :unauthorized
          end
        elsif decoded_token[0]['type'] == "doctor"
          if Doctor.exists?(user_id)
            @current_doctor = Doctor.find(user_id)
          else
            render json: { error: 'Invalid token' }, status: :unauthorized
          end
        else
          render json: { error: 'Invalid token type' }, status: :unauthorized
        end
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Missing token' }, status: :unauthorized
    end
  end
end
