class Api::V2::PatientDocumentController < ApplicationController
  before_action :check_patient
  before_action :set_document
  before_action :check_document, only: %i[update destroy]

  def create
    return render_error('You already have a document', status: :unprocessable_entity) if @document.present?

    case params[:document_type]
    when 'Passport'
      document = Passport.new(document_params)
    when 'IdCard'
      document = IdCard.new(document_params)
    else
      return render_error('Type is invalid', status: :unprocessable_entity)
    end

    if record.save
      PatientDocument.create(patient: @current_patient, document_type: params[:document_type].to_s,
                             document_id: document.id)
      render_success("#{params[:document_type]} was created successfully!", status: :created)
    else
      render_error(record.errors, status: :unprocessable_entity)
    end
  end

  def update
    document = @document.document_type.constantize.find(patient_document.document_id)

    if document.update(document_params)
      render_success('Document was updated successfully')
    else
      render_error('Document cannot be updated', status: :unprocessable_entity)
    end
  end

  def destroy
    if patient_document.document_type.constantize.find(patient_document.document_id).destroy && patient_document.destroy
      render_success('Document was deleted successfully')
    else
      render_error('Document does not exist', status: :bad_request)
    end
  end

  private

  def document_params
    params.permit(:series, :number, :issued_by, :date)
  end

  def check_patient
    render_error('Log In as patient please', status: :unauthorized) if @current_patient.nil?
  end

  def set_document
    @document = @current_patient.patient_document
  end

  def check_document
    render_error("You haven't got any documents here") if @document.nil?
  end
end
