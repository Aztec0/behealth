# frozen_string_literal: true

class Api::V1::SearchController < ApplicationController
  before_action :force_json
  def search
    @hospitals = Hospital.joins(:doctors).ransack(address_or_city_or_name_or_region_cont: params[:query],
                                                  region_cont: params[:region]).result(distinct: true).limit(5)
    @doctors = Doctor.joins(:hospital).ransack(name_or_surname_or_position_cont: params[:query],
                                               region_cont: params[:region]).result(distinct: true).limit(5)
    render json: { hospitals: @hospitals, doctors: @doctors }, each_serializer: Api::V1::SearchSerializer, status: :ok
  end

  private

  def force_json
    request.format = :json
  end
end
