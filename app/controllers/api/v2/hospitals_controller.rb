# frozen_string_literal: true

class Api::V2::HospitalsController < ApplicationController

  def index
    @pagy, hospitals = pagy(Hospital.all)

    render_success(HospitalsSerializer.new(hospitals))
  end
end
