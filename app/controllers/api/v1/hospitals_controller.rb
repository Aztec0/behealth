# frozen_string_literal: true

class Api::V1::HospitalsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]
  before_action :authorize_request, except: %i[index]
  before_action :set_hospital, only: %i[show update delete]
  def index
    @pagy, hospitals = pagy(Hospital.all)

    render json: hospitals, each_serializer: HospitalsSerializer
  end

  def show
    render json: @hospital
  end

  def create
    @hospital = Hospital.find_by(hospital_params)
    if @hospital.present?
      if @hospital.update(hospital_params)
        render json: { message: 'Hospital update successful', hospital: @hospital }, status: :ok
      else
        render json: { error: @hospital.errors.full_messages }, status: :unprocessable_entity
      end
    else
      hospital = Hospital.new(hospital_params)
      if hospital.save
        render json: { message: 'Hospital created successfully', hospital: hospital }, status: :created
      else
        render json: { error: hospital.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update
    if @hospital.update(hospital_params)
      render json: @hospital
    else
      render json: @hospital.errors, status: :unprocessable_entity
    end
  end

  def delete
    if @hospital.destroy
      render json: { message: 'Hospital deleted' }, status: :ok
    else
      render json: @hospital.errors, status: :unprocessable_entity
    end
  end

  private

  def hospital_params
    params.permit(:name, :address, :region, :city)
  end

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def authorize_request
    authorize Hospital
  end
end
