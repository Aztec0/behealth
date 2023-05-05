class Api::V2::ConclusionsController < ApplicationController
  before_action :set_conclusion, only: [:show, :update]

  # GET /conclusions
  def index
    @conclusions = Conclusion.all

    render json: @conclusions
  end

  # GET /conclusions/1
  def show
    render json: @conclusion
  end

  # POST /conclusions
  def create
    @conclusion = Conclusion.new(conclusion_params)

    if @conclusion.save
      render json: @conclusion, status: :created, location: @conclusion
    else
      render json: @conclusion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conclusions/1
  def update
    if @conclusion.update(conclusion_params)
      render json: @conclusion
    else
      render json: @conclusion.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conclusion
    @conclusion = Conclusion.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def conclusion_params
    params.require(:conclusion).permit(:appointment_id, :doctor_id, :text)
  end
end
