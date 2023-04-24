class Api::V2::PatientDocumentController < ApplicationController
  before_action :check_patient
  before_action :set_document

  def create
    return render_error('You already have a document', status: :unprocessable_entity) if @document.present?

    case params[:document_type]
    when 'Passport'
      record = Passport.new(document_params)
    when 'IdCard'
      record = IdCard.new(document_params)
    else
      return render_error('Type is invalid', status: :unprocessable_entity)
    end

    if record.save
      PatientDocument.create(patient: @current_patient, document_type: "#{params[:document_type]}",
                             document_id: record.id)
      render_success("#{params[:document_type]} was created successfully!", status: :created)
    else
      render_error(record.errors, status: :unprocessable_entity)
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
    patient_document = @current_patient.patient_document

    return render_error("You haven't got any documents here") if patient_document.nil?

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
end
