class Api::V1::DoctorsController < ApplicationController
  before_action :set_doctor, only: :show

  def index
    doctors = Doctor.all
    render json: doctors, each_serializer: DoctorSerializer, action: :index
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.hospital = set_current_user.hospital

    if @doctor.save
      render json: @doctor, status: :created, location: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @doctor, serializer: DoctorSerializer, action: :show
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(
      :name, :surname, :email, :phone, :birthday, :position,
      :hospital_id, :password, :password_confirmation
    )
  end
end
