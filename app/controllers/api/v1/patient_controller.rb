# frozen_string_literal: true

class Api::V1::PatientController < ApplicationController
  before_action :authorize_request, only: %i[show delete]
  before_action :set_patient, only: %i[show update delete]

  def show
    render json: @patient
  end

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

  def delete
    if @patient.destroy
      render json: { message: 'Patient deleted successfully' }, status: :ok
    else
      render json: { message: 'Something went wrong' }, status: :unprocessable_entity
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:email, :password)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def authorize_request
    authorize Patient
  end
end
