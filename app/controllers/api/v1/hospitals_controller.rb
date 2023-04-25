# frozen_string_literal: true

class Api::V1::HospitalsController < ApplicationController
  # before_action :authenticate_request

  def index
    @pagy, hospitals = pagy(Hospital.all)

    render json: hospitals, each_serializer: HospitalsSerializer, action: :index
  end

  def create; end
end
