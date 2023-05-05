# frozen_string_literal: true

class Api::V1::PersonalInfoController < ApplicationController
  before_action :authenticate_patient_user
  before_action :set_document
  before_action :check_document, only: :destroy
  before_action :find_document, only: %i[index update destroy]

  def index
    if @patient_document.present?
      document = if @patient_document.document_type == 'Passport'
                   PassportSerializer.new(@document)
                 elsif @patient_document.document_type == 'IdCard'
                   IdCardSerializer.new(@document)
                 end
    end

    render json: { contact_info: current_user.contact_info, main_info: current_user.main_info,
                   document: document }
  end

  def create
    if @patient_document.present?
      return render json: { message: 'You already have a document' }, status: :unprocessable_entity
    end

    case params[:document_type]
    when 'Passport'
      record = Passport.new(document_params)
    when 'IdCard'
      record = IdCard.new(document_params)
    else
      return render json: { message: 'Type is invalid' }, status: :unprocessable_entity
    end

    if record.save
      PatientDocument.create(patient: @current_patient, document_type: params[:document_type].to_s,
                             document_id: record.id)
      render json: { status: 'SUCCESS', message: "#{params[:document_type]} was created successfully!",
                     data: record }, status: :created
    else
      render json: record.errors, status: :unprocessable_entity
    end
  end

  def update
    case params[:type]
    when 'patient_info'
      if @current_patient.update(patient_params)
        render json: { message: 'Patient information was updated successfully' }, status: :ok
      else
        render json: { message: 'Patient information cannot be updated' }, status: :unprocessable_entity
      end
    when 'document'
      check_document

      if @document.update(document_params)
        render json: { message: 'Document was updated successfully' }, status: :ok
      else
        render json: { message: 'Document cannot be updated' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Type is invalid' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @document.destroy && @patient_document.destroy
      render json: { message: 'Document was deleted successfully' }, status: :ok
    else
      render json: { message: 'Document does not exist' }, status: :bad_request
    end
  end

  private

  def check_document
    render json: { message: "You haven't got any documents here" } if @patient_document.nil?
  end

  def document_params
    params.permit(:series, :number, :issued_by, :date)
  end

  def patient_params
    params.permit(:email, :phone, :second_name, :birthday, :tin, :sex).merge(first_name: params[:name],
                                                                             last_name: params[:surname])
  end

  def set_document
    @patient_document = current_user.patient_document
  end

  def find_document
    if @patient_document.present?
      @document = @patient_document.document
    end
  end
end
