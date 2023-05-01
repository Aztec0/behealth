class Api::V1::TagsController < ApplicationController
  skip_before_action :authenticate_request
  def index
    tags = Tag.all
    render json: tags
  end

  def create
  end

  def show

  end
end
