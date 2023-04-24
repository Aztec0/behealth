# frozen_string_literal: true

class Api::V1::HospitalsController < ApplicationController
  before_action :authenticate_request

  def index
    hospitals = Hospital.all

    render json: hospitals, each_serializer: HospitalSerializer
  end

  def show
    hospital = Hospital.find(params[:id])
    render json: hospital
  end

  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      render json: @hospital, status: :created
    else
      render json: @hospital.errors, status: :unprocessable_entity
    end
  end

  private

  def hospital_params
    params.require(:hospital).permit( :address, :city, :name, :region, :tag_list )
  end
end
