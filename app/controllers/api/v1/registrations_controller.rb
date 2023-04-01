class Api::V1::RegistrationsController < ApplicationController
  # before_action :set_patient, only: %i[ confirmation ]

  def signup
    if (params[:email] && params[:password]).blank?
      return render json: {error: 'Email or password not present' }
    end

    @patient = Patient.find_by(email: params[:email])

      if @patient.present?
        @patient.generate_confirm_token!
        PatientMailer.registration(@patient).deliver_now
        render json: 'Email already use, we resend mail'
      else @patient = Patient.new(email: params[:email], password: params[:password])
          @patient.generate_confirm_token!
          PatientMailer.registration(@patient).deliver_now
          render json: "We send email to your email address"
      end
    # else
    #   render json: "something wrong"
    end

  def confirmation
    token = params[:token].to_s
    @patient = Patient.find_by(confirm_token: token)
    if @patient.present? && @patient.token_valid?
    @patient.update(patient_params)
      if @patient.save!
        @patient.email_activate
        render json: 'ok'
      else
        render json: 'error1'
      end
    else
      render json: 'error2'
    end
  end

  private

  def patient_params
    params.permit(:birthday, :name, :surname, :phone, email_confirmed: true)
  end

end