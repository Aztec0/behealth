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
    if current_user.save(validate: false)
      if params[:tag_list].present?
        current_user.tags.destroy_all
        params[:tag_list].split(',').map do |n|
          Tag.where(tag_name: n.strip, tagable: current_user).first_or_create!
        end
      end
      render json: { status: 'Parameters updated' }, status: :ok
    else
      render json: { error: 'Something went wrong' }, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.permit(:second_email, :second_phone, :about, :admission_price)
  end
end
