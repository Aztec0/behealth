# frozen_string_literal: true

class Api::V1::HeadDoctorsController < ApplicationController
  before_action :authenticate_request
  before_action :authorize_request
  before_action :head_doctor, only: %i[index create_doctor create_hospital delete_doctor]
  def index
    @doctors = Doctor.by_head_doctor(@head_doctor.id)

    render json: @doctors, status: :ok
  end

  def create_doctor
    doctor = @head_doctor.create_doctor(doctor_params.merge(hospital_id: @head_doctor.hospital_id, head_doctor_id: @head_doctor.id))
    if doctor.save!
      render json: doctor, status: :created
    else
      render json: { error: 'Unable to create doctor' }, status: :unprocessable_entity
    end
  end

  def create_hospital
    if @head_doctor.hospital.present?
      if @head_doctor.hospital.update(hospital_params)
        render json: { message: 'Hospital update successful', hospital: hospital_params }, status: :ok
      else
        render json: { error: @head_doctor.hospital.errors.full_messages }, status: :unprocessable_entity
      end
    else
      hospital = Hospital.new(hospital_params.merge(doctor_id: @head_doctor.id))
      if hospital.save
        @head_doctor.update(hospital_id: hospital.id)
        render json: { message: 'Hospital created successfully', hospital: hospital }, status: :created
      else
        render json: { error: hospital.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def delete_doctor
    head_doctor = @head_doctor
    message = head_doctor.delete_doctor(params[:id], head_doctor.id)
    render json: { message: message }
  end

  def canceled_apointments; end

  private

  def doctor_params
    params.permit(
      :name, :surname, :email, :phone, :birthday, :position,
      :hospital_id, :head_doctor_id, :password, :password_confirmation
    )
  end


  def head_doctor
    @head_doctor ||= HeadDoctor.find(current_user.id)
  end

  def hospital_params
    params.permit(:address, :city, :name, :region, :doctor_id)
  end

  def authorize_request
    authorize HeadDoctor
  end
end
