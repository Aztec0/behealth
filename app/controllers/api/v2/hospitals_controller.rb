# frozen_string_literal: true

class Api::V2::HospitalsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]

  def index
    @pagy, hospitals = pagy(Hospital.all)

    render_success({ hospitals: ActiveModelSerializers::SerializableResource.new(hospitals, each_serialize: HospitalsSerializer) })
  end
end
