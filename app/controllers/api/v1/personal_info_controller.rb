class Api::V1::PersonalInfoController < ApplicationController
  before_action :check_patient
  before_action :set_document
  before_action :find_document, only: %i[index update destroy]

  def index
    record = if @patient_document.document_type == 'Passport'
               PassportSerializer.new(@document)
             else
               IdCardSerializer.new(@document)
             end

    render json: { contact_info: @current_patient.contact_info, main_info: @current_patient.main_info,
                   document: record }
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
        render json: { message: 'Patient information was updated successfully'}, status: :ok
      else
        render json: { message: 'Patient information cannot be updated' }, status: :unprocessable_entity
      end
    when 'document'
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
    return render json: { message: "You haven't got any documents here" } if patient_document.nil?

    if @document && @patient_document.destroy
      render json: { message: 'Document was deleted successfully' }, status: :ok
    else
      render json: { message: 'Document does not exist' }, status: :bad_request
    end
  end

  private

  def document_params
    params.permit(:series, :number, :issued_by, :date)
  end

  def patient_params
    params.permit(:email, :phone, :name, :surname, :fathername, :birthday, :tin, :sex)
  end

  def check_patient
    render json: { message: 'Log In as patient please' }, status: :unauthorized if @current_patient.nil?
  end

  def set_document
    @patient_document = @current_patient.patient_document
  end

  def find_document
    @document = @patient_document.document_type.constantize.find(@patient_document.document_id)
  end
end
