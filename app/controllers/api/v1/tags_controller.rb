# frozen_string_literal: true

class Api::V1::TagsController < ApplicationController
  skip_before_action :authenticate_request
  def index
    tags = Tag.select(:tag_name).distinct
    render json: tags
  end

  def show; end
end
