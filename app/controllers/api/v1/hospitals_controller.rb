# frozen_string_literal: true

module Api
  module V1
    class HospitalsController < ApplicationController
      before_action :authenticate_request

      def index
        hospitals = Hospital.all

        render json: hospitals
      end

      def create; end
    end
  end
end
