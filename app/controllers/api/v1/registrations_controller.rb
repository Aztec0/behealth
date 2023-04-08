class Api::V1::RegistrationsController < ApplicationController
  # after_action :activate_patient, only: %i[ confirmation ]

  def signup
    if (params[:email] && params[:password]).blank?
      return render json: {error: 'Email or password not present' }
    end

    @patient = Patient.find_by(email: params[:email])

    if @patient.present?
      @patient.generate_confirm_token!
      PatientMailer.registration(@patient).deliver_now
      render json: 'Email already use, we resend mail'
    else
      @patient = Patient.new(email: params[:email], password: params[:password])
      @patient.generate_confirm_token!
      PatientMailer.registration(@patient).deliver_now
      render json: "We send email to your email address"
    end
  end

  def confirmation
    token = params[:token].to_s
    @patient = Patient.find_by(confirm_token: token)
    @doctor = Doctor.find_by(confirm_token: token)
    if @patient.present? && @patient.token_valid?
      @patient.update(patient_params)
      if @patient.save!
        @patient.email_activate
        render json: 'Email activated, you successfully registered'
      else
        render json: 'Something went wrong'
      end
    elsif @doctor.present? && @doctor.token_valid?
      @doctor.update(doctor_params)
      if @doctor.save!
        @doctor.email_activate
        render json: 'Email activated, you successfully registered', status: :ok
      else
        render json: 'Somthings went wrong. Try generating a new token.', status: :unauthorized
      end
    else
      render json: 'Link not valid or expired. Try generating a new link.'
    end
  end

  private

  def doctor_params
    params.permit(
      :name, :surname, :email, :phone, :birthday, :position,
      :hospital_id, :password, :password_confirmation
    )
  end

  def patient_params
    params.permit(:birthday, :name, :surname, :phone)
  end
end
