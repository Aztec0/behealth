# frozen_string_literal: true

class Api::V1::SearchController < ApplicationController

  skip_before_action :authenticate_request
  def search
    region = params[:region]
    @pagy, hospitals = pagy(Hospital.all)
    @pagy, doctors = pagy(Doctor.all)

    if region.present? && Hospital.exists?(region: region)
      @pagy, hospitals = pagy(hospitals.where(region: region))
      @pagy, doctors = pagy(doctors.joins(:hospital).where(hospitals: { region: region }))
    end

    if params[:query].present?
      @pagy, hospitals = pagy(hospitals.where('address ILIKE ? OR city ILIKE ? OR name ILIKE ?', "%#{params[:query]}%",
                                  "%#{params[:query]}%", "%#{params[:query]}%"))
      @pagy, doctors = pagy(doctors.where('doctors.name ILIKE ? OR doctors.surname ILIKE ? OR doctors.position ILIKE ?',
                              "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"))
    end

    if hospitals.any? || doctors.any?
      render json: {
        hospitals: ActiveModelSerializers::SerializableResource.new(hospitals, each_serializer: HospitalsSerializer),
        doctors: ActiveModelSerializers::SerializableResource.new(doctors, each_serializer: DoctorSerializer),
      }, status: :ok
    else
      render json: { message: 'No results found' }, status: :unprocessable_entity
    end
  end

  def search_doctors_by_specialty
    position = params[:position]

    @pagy, doctors = pagy(if position.present?
                            Doctor.where('position ILIKE ?', "%#{position}%")
                          else
                            Doctor.all
                          end)

    if params[:query].present?
      @pagy, doctors = pagy(doctors.where('name ILIKE ? OR surname ILIKE ? OR position ILIKE ?',
                              "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"))
    end

    @pagy, doctors = pagy(doctors.order('RANDOM()'))

    if doctors.any?
      render json: {
        doctors: ActiveModelSerializers::SerializableResource.new(doctors, each_serializer: DoctorSerializer)
      }, status: :ok
    else
      render json: { message: 'No results found' }, status: :unprocessable_entity
    end
  end

  def search_hospitals
    if params[:query].present?
      @pagy, hospitals = pagy(Hospital.where('name ILIKE ?', "%#{params[:query]}%"))
    else
      @pagy, hospitals = pagy(Hospital.all)
    end

    if hospitals.any?
      render json: {
        hospitals: ActiveModelSerializers::SerializableResource.new(hospitals, each_serializer: HospitalsSerializer)
      }, status: :ok
    else
      render json: { message: 'No results found' }, status: :unprocessable_entity
    end
  end
end
