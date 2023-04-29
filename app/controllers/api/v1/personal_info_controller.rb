# frozen_string_literal: true

class Api::V1::PersonalInfoController < ApplicationController
  before_action :authenticate_request

  def index
    unless @current_patient.nil?
      patient_document = @current_patient.patient_document
        document = patient_document.document_type.constantize.find(patient_document.document_id)
        record = patient_document.document_type == 'Passport' ? PassportSerializer.new(document) : IdCardSerializer.
          new(document)

      render json: { contact_info: @current_patient.contact_info, main_info: @current_patient.main_info,
                     document: record }
    end
  end

  def create
    if @current_patient.patient_document.nil?
      case params[:document_type]
      when 'Passport'
        record = Passport.new(document_params)
      when 'IdCard'
        record = IdCard.new(document_params)
      else
        render json: { message: 'Type is invalid' }, status: :unprocessable_entity and return
      end

      if record.save
        PatientDocument.create(patient: @current_patient, document_type: "#{params[:document_type]}",
                               document_id: record.id)
        render json: { status: 'SUCCESS', message: "#{params[:document_type]} was created successfully!",
                       data: record }, status: :created
      else
        render json: record.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'You already have a document' }, status: :unprocessable_entity
    end
  end

  def update
    unless @current_patient.nil?
      case params[:type]
      when 'patient_info'
        if @current_patient.update(patient_params)
          render json: { message: 'Patient information was updated successfully'}, status: :ok
        else
          render json: { message: 'Patient information cannot be updated' }, status: :unprocessable_entity
        end
      when 'document'
        patient_document = @current_patient.patient_document
        record = patient_document.document_type.constantize.find(patient_document.document_id)

        if record.update(document_params)
          render json: { message: 'Document was updated successfully' }, status: :ok
        else
          render json: { message: 'Document cannot be updated' }, status: :unprocessable_entity
        end
      else
        render json: { message: 'Type is invalid' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Log In as patient please' }, status: :unauthorized
    end
  end

  def destroy
    unless @current_patient.nil?
      patient_document = @current_patient.patient_document

      if patient_document.nil?
        render json: { message: "You haven't got any documents here" }
      else
        if patient_document.document_type.constantize.find(patient_document.document_id).destroy && patient_document.destroy
          render json: { message: 'Document was deleted successfully' }, status: :ok
        else
          render json: { message: 'Document does not exist' }, status: :bad_request
        end
      end
    end
  end

  private

  def document_params
    params.permit(:series, :number, :issued_by, :date)
  end

  def patient_params
    params.permit(:email, :phone, :name, :surname, :fathername, :birthday, :tin, :sex)
  end
end
