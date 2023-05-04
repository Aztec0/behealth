# frozen_string_literal: true

class Api::V1::DoctorsCabinetController < ApplicationController
  before_action :authenticate_doctor_user

  def personal_info
    render json: @current_doctor, serializer: DoctorsCabinetSerializer, action: :personal_info, status: :ok
  end

  def professional_info
    render json: @current_doctor, serializer: DoctorsCabinetSerializer, action: :professional_info, status: :ok
  end

  def update
    if @current_doctor.assign_attributes(doctor_params)
      @current_doctor.save(validates: false)
      render json: { status: 'Parameters updated' }, status: :ok
    else
      render json: { error: 'Something went wrong' }, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.permit(:second_email, :second_phone, :description, :price)
  end
end
