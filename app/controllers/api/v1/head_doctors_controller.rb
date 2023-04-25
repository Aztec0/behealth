# frozen_string_literal: true

class Api::V1::HeadDoctorsController < ApplicationController
  before_action :authenticate_request
  before_action :authorize_request
  def index
    @doctors = Doctor.list_doctor_by_hospital(current_user.hospital_id)
    if @doctors
      render json: @doctors, status: :ok
    else
      render json: { error: 'Unable to fetch doctors' }, status: :unauthorized
    end
  end

  def create_doctor
    doctor = current_user.create_doctor(doctor_params.merge(hospital_id: current_user.hospital_id))
    if doctor.save!
      render json: doctor, status: :created
    else
      render json: { error: 'Unable to create doctor' }, status: :unprocessable_entity
    end
  end

  def create_hospital
    byebug
    if current_user.hospital.present?
      if current_user.hospital.update(hospital_params)
        render json: { message: 'Hospital update successful', hospital: hospital_params }, status: :ok
      else
        render json: { error: current_user.hospital.errors.full_messages }, status: :unprocessable_entity
      end
    else
      hospital = Hospital.new(hospital_params.merge(doctor_id: current_user.id))
      if hospital.save
        current_user.update(hospital_id: hospital.id)
        render json: { message: 'Hospital created successfully', hospital: hospital }, status: :created
      else
        render json: { error: hospital.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def delete
    doctor = Doctor.find_by(id: params[:id])
    if doctor.present?
      doctor.destroy
      render json: { message: "Doctor with ID #{params[:id]} has been deleted successfully." }, status: :no_content
    else
      render json: { error: "Unable to delete doctor with ID #{params[:id]}. Doctor does not exist" },
             status: :not_found
    end
  end

  def canceled_apointments; end

  private

  def doctor_params
    params.permit(
      :name, :surname, :second_name, :email, :phone, :birthday, :position,
      :hospital_id
    )
  end

  def hospital_params
    params.permit(:address, :city, :name, :region, :doctor_id)
  end

  def authorize_request
    authorize HeadDoctor
  end
end
