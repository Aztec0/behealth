class Api::V1::PasswordsController < ApplicationController
  def forgot
    if params[:email].blank?
      return render json: {error: 'Email not present' }
    end

    doctor = Doctor.find_by(email: params[:email]) #if present find doctor by email

    if doctor.present?
      doctor.generate_password_token! #generate pass token
      PasswordMailer.test_mailer(doctor).deliver_now
      render json: doctor
    else
      render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
    end
  end

  def reset
    token = params[:token].to_s

    if params[:email].blank?
      return render json: {error: 'Token not present'}
    end

    doctor = Doctor.find_by(reset_password_token: token)

    if doctor.present? && doctor.password_token_valid?
      if doctor.reset_password!(params[:password])
        render json: {status: 'ok'}, status: :ok
    else
      render json: {error: doctor.errors.full_messages}, status: :unprocessable_entity
    end
  else
    render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
  end
end
end
