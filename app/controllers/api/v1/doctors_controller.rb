# frozen_string_literal: true

module Api
  module V1
    class DoctorsController < ApplicationController
      before_action :set_doctor, only: :show

      def index
        doctors = Doctor.all
        render json: doctors, each_serializer: DoctorIndexSerializer
      end

      def show
        render json: @doctor, serializer: DoctorShowSerializer
      end

      private

      def set_doctor
        @doctor = Doctor.find(params[:id])
      end
    end
  end
end
