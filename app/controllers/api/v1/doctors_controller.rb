# frozen_string_literal: true

class Api::V1::DoctorsController < ApplicationController
  before_action :authenticate_request, except: %i[index]
  before_action :authorize_request, only: %i[create_doctor create_hospital delete list_doctor_by_hospital]
  before_action :set_doctor, only: :show

  def index
    @pagy, doctors = pagy(Doctor.all)
    render json: doctors, each_serializer: DoctorSerializer, action: :show
  end

  def canceled_apointments; end

  def create_hospital
    if current_user.hospital.present?
      if current_user.hospital.update(hospital_params)
        render json: { message: 'Hospital update successful', hospital: hospital_params }, status: :ok
      else
        render json: { error: current_user.hospital.errors.full_messages }, status: :unprocessable_entity
      end
    else
      hospital = Hospital.new(hospital_params)
      if hospital.save
        current_user.update(hospital_id: hospital.id)
        render json: { message: 'Hospital created successfully', hospital: hospital }, status: :created
      else
        render json: { error: hospital.errors.full_messages }, status: :unprocessable_entity
      end
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

  def delete
    doctor = Doctor.find_by(id: params[:id])
    if doctor.present? && doctor.hospital_id == current_user.hospital_id && current_user.id != doctor.id
      doctor.destroy
      render json: { message: "Doctor with ID #{params[:id]} has been deleted successfully." },
             status: :no_content
    else
      render json: { error: "Unable to delete doctor with ID #{params[:id]}.
                             Doctor does not exist or does not belong to this hospital
                             or this is a current doctor." },
             status: :not_found
    end
  end

  def list_doctor_by_hospital
    @pagy, doctors = pagy(Doctor.list_doctor_by_hospital(current_user.hospital_id))
    if doctors
      render json: doctors, each_serializer: DoctorSerializer, action: :index, status: :ok
    else
      render json: { error: 'Unable to fetch doctors' }, status: :unauthorized
    end
  end

  def show
    render json: @doctor, serializer: DoctorSerializer, action: :show
  end

  private

  def doctor_params
    params.permit(
      :name, :surname, :second_name, :email, :phone, :birthday, :position,
      :hospital_id
    )
  end

  def hospital_params
    params.permit(:address, :city, :name, :region)
  end

  def authorize_request
    authorize Doctor
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
