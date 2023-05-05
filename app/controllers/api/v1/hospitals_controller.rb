# frozen_string_literal: true

class Api::V1::HospitalsController < ApplicationController

  def index
    @pagy, hospitals = pagy(Hospital.all)

    render json: hospitals, each_serializer: HospitalsSerializer
  end

  def create; end
end
