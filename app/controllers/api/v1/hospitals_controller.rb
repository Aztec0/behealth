# frozen_string_literal: true

class Api::V1::HospitalsController < ApplicationController
  before_action :authenticate_request

  def index
    hospitals = Hospital.all

    render json: hospitals
  end

  def create; end
end
