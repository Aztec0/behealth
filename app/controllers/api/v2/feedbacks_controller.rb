# frozen_string_literal: true

class Api::V2::FeedbacksController < ApplicationController
  skip_before_action :authenticate_request, only: :index
  before_action :authenticate_patient_user, only: %i[create update destroy]
  before_action :check_type, only: %i[index create]
  before_action :set_feedback, only: %i[update destroy]
  before_action :check_permission, only: %i[update destroy]
  before_action :set_object, only: %i[index create]

  def index
    feedbacks = @object.feedbacks

    render_success({ feedbacks: ActiveModelSerializers::SerializableResource.new(feedbacks,
                                                                                 each_serializer: FeedbacksSerializer) })
  end

  def create
    feedback = current_user.feedbacks.build(feedback_params.merge(doctorable_type: params[:type].capitalize,
                                                                  doctorable_id: params[:id]))

    if feedback.save
      @object.update_columns(rating: @object.feedbacks.average(:rating).to_f)
      render_success('Feedback was created successfully!', status: :created)
    else
      render_error(feedback.errors, status: :unprocessable_entity)
    end
  end

  def update
    object = @feedback.doctorable

    if @feedback.update(feedback_params)
      object.update_columns(rating: object.feedbacks.average(:rating).to_f)
      render_success('Feedback was updated successfully!')
    else
      render_error(@feedback.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    if @feedback.destroy
      render_success('Feedback was destroyed successfully!')
    else
      render_error(@feedback.errors, status: :unprocessable_entity)
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
