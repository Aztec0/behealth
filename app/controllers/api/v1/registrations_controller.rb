# frozen_string_literal: true

class Api::V1::RegistrationsController < ApplicationController
  # after_action :activate_patient, only: %i[ confirmation ]

  def signup
    if (params[:email] && params[:password]).blank?
      return render json: { error: 'Email or password not present' }, status: :unprocessable_entity
    end

    @patient = Patient.find_by(email: params[:email])

    if @patient.present?
      @patient.generate_confirm_token!
      PatientMailer.registration(@patient).deliver_now
      render json: { error: 'Email address already exists in the system. We resend email' }, status: :conflict
    else
      @patient = Patient.new(email: params[:email], password: params[:password])
      @patient.generate_confirm_token!
      PatientMailer.registration(@patient).deliver_now
      render json: { status: 'We send email to your email address' }, status: :ok
    end
  end

  def confirmation
    token = params[:token].to_s
    @patient = Patient.find_by(confirm_token: token)
    if @patient.present? && @patient.token_valid?
      @patient.update(patient_params)
      if @patient.save!
        @patient.email_activate
        render json: {status: 'Email activated, you successfully registered' }, status: :ok
      else
        render json: { error: 'Something went wrong' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Link not valid or expired. Try generating a new link.' }, status: :unprocessable_entity
    end
  end

  private

  def patient_params
    params.permit(:birthday, :name, :second_name, :surname, :phone)
  end
end
