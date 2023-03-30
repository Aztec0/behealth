class Api::V1::DoctorsFeedbacksController < ApplicationController
  before_action :authenticate_request

  def create
    unless @current_patient.nil?
      doctors_feedback = @current_patient.doctors_feedbacks.build(feedback_params)

      if doctors_feedback.save
        render json: { status: 'SUCCESS', message: 'Feedback was created successfully!', data: doctors_feedback }, status: :created
      else
        render json: doctors_feedback.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Only patients are allowed to create feedback' }, status: :forbidden
    end
  end

   private

  def feedback_params
    params.permit(:doctor_id, :rating, :title, :body)
  end
end
