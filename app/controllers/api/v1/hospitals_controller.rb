# frozen_string_literal: true

class Api::V1::HospitalsController < ApplicationController

  def index
    @pagy, hospitals = pagy(Hospital.all)

    render json: hospitals, each_serializer: HospitalsSerializer, action: :index
  end

  def create; end
end
