class Api::V2::AdditionalInfoController < ApplicationController
  def index
    render_success(AdditionalInfoSerializer.new(@current_patient))
  end
end
