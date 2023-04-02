# frozen_string_literal: true

class Api::V1::HeadDoctorsController < ApplicationController
  before_action :authenticate_request
  before_action :authorize_head_doctor

  def index
    doctors = head_doctor.doctors
    # Sort by creation date
    doctors = doctors.by_creation_date if params[:by_creation_date]
    # Sort by alphabetical order
    doctors = doctors.alphabetically if params[:alphabetically]
    # Filter by specialization
    doctors = doctors.by_specialization(params[:specialization]) if params[:specialization]

    render json: doctors, status: :ok
  end

  def create
    hospital = Hospital.find_by(id: doctor_params[:hospital_id])
    if hospital.nil?
      render json: { error: 'Hospital not found' }, status: :unprocessable_entity
    else
      doctor = head_doctor.create_doctor(doctor_params)
      if doctor
        render json: doctor, status: :created
      else
        render json: { error: doctor.errors.full_message }, status: :unprocessable_entity
      end
    end
  end

  def create_hospital
    hospital = Hospital.new(hospital_params)
    if hospital.save
      render json: hospital, status: :created
    else
      render json: { error: hospital.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete
    if head_doctor.delete_doctor(params[:id])
      render json: { message: 'Doctor deleted' }, status: :ok
    else
      render json: { massage: 'Doctor not found' }, status: :not_found
    end
  end

  def canceled_apointments; end

  private

  # this part is for authenticate_request
  def doctor_params
    params.require(:doctor).permit(
      :name, :surname, :email, :phone, :birthday, :position,
      :hospital_id, :password, :password_confirmation
    )
  end

  # this part is for create doctor
  def head_doctor
    @head_doctor ||= HeadDoctor.find(user.id)
  end

  def authorize_head_doctor
    return if user.is_a?(Doctor)

    render_error('Unauthorized', :unauthorized)
  end

  def hospital_params
    params.require(:hospital).permit(:name, :address, :phone, :email)
  end
end
