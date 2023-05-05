# frozen_string_literal: true

class Api::V2::PersonalInfoController < ApplicationController
  before_action :authenticate_patient_user

  def index
    patient_document = current_user.patient_document
    document = patient_document.document if patient_document.present?

    render_success({ contact_info: current_user.contact_info, main_info: current_user.main_info,
                     document: document })
  end

  def update
    if current_user.update(patient_params)
      render_success('Patient information was updated successfully')
    else
      render_error('Patient information cannot be updated', status: :unprocessable_entity)
    end
  end

  private

  def patient_params
    params.permit(:email, :phone, :first_name, :last_name, :second_name, :birthday, :tin, :sex)
  end
end
