# frozen_string_literal: true

class Api::V1::DoctorsCabinetController < ApplicationController
  before_action :authenticate_doctor_user

  def personal_info
    render json: current_user, serializer: DoctorsCabinetSerializer, action: :personal_info, status: :ok
  end

  def professional_info
    render json: current_user, serializer: DoctorsCabinetSerializer, action: :professional_info, status: :ok
  end

  def update
    current_user.assign_attributes(doctor_params)
    current_user.save(validate: false)
      if tag_list[:tag_list].present?
        tag_list[:tag_list].split(',').map do |n|
          tag = Tag.find_or_initialize_by(tag_name: n.strip, tagable: current_user)
          tag.save unless tag.persisted?
        end
      render json: { status: 'Parameters updated' }, status: :ok
    else
      render json: { error: 'Something went wrong' }, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:second_email, :second_phone, :about, :admission_price)
  end

  def tag_list
    { tag_list: params.fetch(:tag_list, []) }
  end
end
