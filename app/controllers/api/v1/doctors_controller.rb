# frozen_string_literal: true

class Api::V1::DoctorsController < ApplicationController
  before_action :authenticate_doctor_user, except: %i[index show]
  before_action :set_doctor, only: :show

  def index
    @pagy, doctors = pagy(Doctor.all)
    render json: doctors, each_serializer: DoctorShowSerializer
  end

  # in progress
  def staff_appointments
    @pagy, appointments = pagy(Appointment.staff_appointments(current_user.hospital_id))
    render json: appointments, each_serializer: AppointmentSerializer, action: :show
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

  def authorize_request
    authorize Doctor
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
