# frozen_string_literal: true

class Api::V1::HospitalsController < ApplicationController
  skip_before_action :authenticate_request
  def index
    @pagy, hospitals = pagy(Hospital.all)

    render json: hospitals, each_serializer: HospitalsSerializer
  end

  def create
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

  def update
    hospital = Hospital.find_by(id: params[:id])
    hospital.update(hospital_params)
    if tag_list[:tag_list].present?
      tag_list[:tag_list].split(',').map do |n|
        tag = Tag.find_or_initialize_by(tag_name: n.strip, tagable: hospital)
        tag.save unless tag.persisted?
      end
    end
    render json: hospital, each_serializer: HospitalsSerializer
  end

  private

  def hospital_params
    params.require(:hospital).permit(:address, :city, :name, :region)
  end

  def tag_list
    { tag_list: params.fetch(:tag_list, []) }
  end
end
