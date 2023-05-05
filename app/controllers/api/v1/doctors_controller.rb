# frozen_string_literal: true

class Api::V1::DoctorsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]
  before_action :authenticate_doctor_user, except: %i[index]
  before_action :authorize_request, except: %i[index show]
  before_action :set_doctor, only: %i[show delete]

  def index
    @pagy, doctors = pagy(Doctor.all)
    render json: doctors, each_serializer: DoctorShowSerializer
  end

  def staff_appointments
    @pagy, appointments = pagy(Appointment.staff_appointments(current_user.hospital_id))
    render json: appointments, each_serializer: AppointmentSerializer, action: :show
  end

  def show
    render json: @doctor, serializer: DoctorSerializer, action: :show
  end

  def create
    @doctor = Doctor.create_doctor(doctor_params)
    if @doctor.persisted?
      render json: @doctor, status: :created
    else
      render json: { error: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create_doctor
    doctor = Doctor.create_doctor(doctor_params.merge(hospital_id: current_user.hospital_id))
    if doctor.save!
      render json: doctor, status: :created
    else
      render json: { error: 'Unable to create doctor' }, status: :unprocessable_entity
    end
  end

  def delete
    if @doctor.destroy
      render json: { message: 'Doctor deleted successfully' }, status: :ok
    else
      render json: { error: 'Unable to delete doctor' }, status: :unprocessable_entity
    end
  end

  def delete_doctor
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
      render json: doctors, each_serializer: DoctorByHospitalSerializer, action: :index, status: :ok
    else
      render json: { error: 'Unable to fetch doctors' }, status: :unauthorized
    end
  end

  private

  def doctor_params
    params.permit(
      :first_name, :second_name, :last_name, :email, :phone, :birthday, :position,
      :hospital_id, :password, :role
    )
  end

  def authorize_request
    authorize Doctor
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
