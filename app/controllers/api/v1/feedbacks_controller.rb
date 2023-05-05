# frozen_string_literal: true

class Api::V1::FeedbacksController < ApplicationController
  skip_before_action :authenticate_request, only: :index
  before_action :authenticate_patient_user, only: %i[create update destroy]
  before_action :check_type, only: %i[index create]
  before_action :set_feedback, only: %i[update destroy]
  before_action :check_permission, only: %i[update destroy]
  before_action :set_object, only: %i[index create]

  def index
    feedbacks = @object.feedbacks

    render json: feedbacks, status: :ok
  end

  def create
    feedback = current_user.feedbacks.build(feedback_params.merge(doctorable_type: params[:type].capitalize,
                                                                  doctorable_id: params[:id]))

    if feedback.save
      @object.update(rating: @object.feedbacks.average(:rating).to_f)
      render json: { message: 'Feedback was created successfully!', data: feedback }, status: :created
    else
      render json: feedback.errors, status: :unprocessable_entity
    end
  end

  def update
    object = @feedback.doctorable

    if @feedback.update(feedback_params)
      object.update(rating: object.feedbacks.average(:rating).to_f)
      render json: { message: 'Feedback was updated successfully!', data: @feedback }, status: :ok
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @feedback.destroy
      render json: { message: 'Feedback was destroyed successfully!' }, status: :ok
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  private

  def check_type
    if params[:type] != 'doctor' && params[:type] != 'hospital'
      render json: { error: 'Type is incorrect' }, status: :unprocessable_entity
    end
  end

  def check_permission
    if @feedback.patient.id != current_user.id
      render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
    end
  end

  def feedback_params
    params.permit(:rating, :title, :body)
  end

  def set_object
    @object = Doctor.find(params[:id]) if params[:type].downcase == 'doctor'
    @object = Hospital.find(params[:id]) if params[:type].downcase == 'hospital'
  end

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end
end
