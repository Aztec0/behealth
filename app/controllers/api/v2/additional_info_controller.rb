# frozen_string_literal: true

class Api::V2::AdditionalInfoController < ApplicationController
  before_action :authenticate_patient_user

  def index
    render_success(AdditionalInfoSerializer.new(current_user))
  end
end
