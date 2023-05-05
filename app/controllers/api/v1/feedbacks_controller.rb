# frozen_string_literal: true

class Api::V1::FeedbacksController < ApplicationController
  before_action :authenticate_request, only: :create
  before_action :set_doctor

  def index
    feedbacks = @doctor.feedbacks

    render json: feedbacks
  end

      def create
        if @current_patient.present?
          render json: { error: 'Only patients are allowed to create feedback' }, status: :forbidden
        else
          feedback = @current_patient.feedbacks.build(feedback_params)

          if feedback.save
            render json: { status: 'SUCCESS', message: 'Feedback was created successfully!', data: feedback },
                   status: :created
          else
            render json: feedback.errors, status: :unprocessable_entity
          end
        end
      end

      private

  def feedback_params
    params.permit(:rating, :title, :body).merge(doctor: @doctor)
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
