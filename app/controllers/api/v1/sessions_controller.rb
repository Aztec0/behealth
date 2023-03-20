class Api::V1::SessionsController < ApplicationController

  def create

    doctor = user.find_by(email: params[:email])
    if patient && patient.authenticate(params[:password])
      # Generate JWT token for patient
      token = JWT.encode({ patient_id: patient.id, type: "patient" }, Rails.application.secret_key_base)
      render json: { token: token }
    elsif doctor && doctor.authenticate(params[:password])
      # Generate JWT token for doctor
      token = JWT.encode({ doctor_id: doctor.id, type: "doctor" }, Rails.application.secret_key_base)
      render json: { token: token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def user
    params[:user_type].constantize
  end
end
