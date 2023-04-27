class Api::V1::AdditionalInfoController < ApplicationController
  def index
    return render json: { message: 'Log In as patient please' }, status: :unauthorized if @current_patient.nil?

    address = PatientAddressSerializer.new(@current_patient.patient_address)
    work = PatientWorkSerializer.new(@current_patient.patient_work)

    render json: { address: address, workPlace: work, preferenceCategories: nil }
  end

  def create
    return render json: { message: 'Log In as patient please' }, status: :unauthorized if @current_patient.nil?

    case params[:type].downcase
    when 'address'
      if @current_patient.patient_address.present?
        return render json: {message: 'Address already present'}, status: :unprocessable_entity
      end

      record = @current_patient.build_patient_address(patient_address_params)
    when 'work'
      if @current_patient.patient_work.present?
        return render json: {message: 'Work already present'}, status: :unprocessable_entity
      end

      record = @current_patient.build_patient_work(patient_work_params)
    else
      render json: {message: 'Type is invalid'}, status: :unprocessable_entity and return
    end

    if record.save
      render json: { status: 'SUCCESS', message: "#{params[:type].capitalize} was created successfully!",
                     data: record }, status: :created
    else
      render json: record.errors, status: :unprocessable_entity
    end
  end

  def update
    return render json: { message: 'Log In as patient please' }, status: :unauthorized if @current_patient.nil?

    case params[:type].downcase
    when 'address'
      address = @current_patient.patient_address

      return render json: {message: 'There are no addresses here!'}, status: :not_found if address.nil?

      if address.update(patient_address_params)
        render json: { message: 'Address was updated successfully', data: address }, status: :ok
      else
        render json: { message: 'Address cannot be updated' }, status: :unprocessable_entity
      end
    when 'work'
      work = @current_patient.patient_work

      return render json: {message: 'There are no works here!'}, status: :not_found if work.nil?

      if work.update(patient_work_params)
        render json: { message: 'Work was updated successfully', data: work }, status: :ok
      else
        render json: { message: 'Work cannot be updated' }, status: :unprocessable_entity
      end
    else
      render json: {message: 'Type is invalid'}, status: :unprocessable_entity
    end
  end

  def destroy
    return render json: { message: 'Log In as patient please' }, status: :unauthorized if @current_patient.nil?

    case params[:type].downcase
    when 'address'
      record = @current_patient.patient_address
    when 'work'
      record = @current_patient.patient_work
    else
      return render json: { message: 'Type is invalid' }, status: :unprocessable_entity
    end

    if record.nil?
      return render json: { message:
                              "There are no #{params[:type].casecmp('address').zero? ? 'addresses' : 'works'} here!" },
                    status: :not_found
    end

    unless record.patient == @current_patient
      return render json: { message: "You can't perform that action" }, status: :unprocessable_entity
    end

    if record.destroy
      render json: { message: "#{params[:type].capitalize} was deleted successfully" }, status: :ok
    else
      render json: { message: "#{params[:type].capitalize}  does not exist" }, status: :bad_request
    end
  end

  private

  def patient_address_params
    params.permit(:address_type, :settlement, :house, :apartments)
  end

  def patient_work_params
    params.permit(:work_type, :place, :position)
  end
end
