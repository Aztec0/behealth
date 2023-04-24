class Api::V2::PersonalInfoController < ApplicationController
  before_action :check_patient

  def index
    patient_document = @current_patient.patient_document
    document = patient_document.document_type.constantize.find(patient_document.document_id)
    record = patient_document.document_type == 'Passport' ? PassportSerializer.new(document) : IdCardSerializer.new(document)

    render_success({ contact_info: @current_patient.contact_info, main_info: @current_patient.main_info,
                     document: record })
  end

  def update
    if @current_patient.update(patient_params)
      render_success('Patient information was updated successfully')
    else
      render_error('Patient information cannot be updated', status: :unprocessable_entity)
    end
  end

  private

  def patient_params
    params.permit(:email, :phone, :name, :surname, :fathername, :birthday, :tin, :sex)
  end

  def check_patient
    render_error('Log In as patient please', status: :unauthorized) if @current_patient.nil?
  end
end
