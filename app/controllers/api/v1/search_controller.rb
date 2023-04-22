# frozen_string_literal: true

class Api::V1::SearchController < ApplicationController
  before_action :force_json
  def search
    @hospitals = Hospital.includes(:doctors).ransack(address_or_city_or_name_cont: params[:query],
                                                     region_cont: params[:region]).result(distinct: true).limit(5)
    @doctors = Doctor.ransack(name_or_surname_or_position_cont: params[:query],
                              region_cont: params[:region]).result(distinct: true).limit(5)
    # render json: { hospitals: @hospitals, doctors: @doctors }, status: :ok, each_serializer: Api::V1::SearchSerializer
  end

  def search_by_doctor
    @doctor = Doctor.ransack(name_or_surname_or_position_cont: params[:query]).result(distinct: true).limit(5)
  end

  def search_by_hospital
    @hospital = Hospital.ransack(address_or_city_or_name_cont: params[:query],
                                 region_cont: params[:region]).result(distinct: true).limit(5)
  end

  private

  def force_json
    request.format = :json
  end
end
