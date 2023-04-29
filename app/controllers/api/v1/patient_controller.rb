# frozen_string_literal: true

class Api::V1::PatientController < ApplicationController

  def new
    @patient = Patient.new
  end

  def edit
    @patient.find_by(params[:email])
    render json: @patient
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.email.present?
      PatientMailer.registration(@patient).deliver_now
    else
      render :new
    end
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:email, :password)
  end
end
