class Api::V2::AdditionalInfoController < ApplicationController
  before_action :check_patient
  before_action :set_address

  def create
    if @address.nil?
      address = @current_patient.build_patient_address(patient_address_params)
    else
      return render_error('Address already present', status: :unprocessable_entity)
    end

    if address.save
      render_success('Address was created successfully!', status: :created)
    else
      render_error(address.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @address.present?
      if @address.update(patient_address_params)
        render_success('Address was updated successfully')
      else
        render_error('Address cannot be updated', status: :unprocessable_entity)
      end
    else
      render_error('There are no addresses here!')
    end
  end

  def destroy
    return render_error('There are no addresses here!') if @address.nil?
    return render_error("You can't do this action") unless @address.patient == @current_patient

    if @address.destroy
      render_success('Address was deleted successfully')
    else
      render_error('Address  does not exist', status: :bad_request)
    end
  end

  private

  def patient_address_params
    params.permit(:address_type, :settlement, :house, :apartments)
  end

  def patient_work_params
    params.permit(:work_type, :place, :position)
  end

  def check_patient
    render_error('Log In as patient please', status: :unauthorized) if @current_patient.nil?
  end

  def set_address
    @address = @current_patient.patient_address
  end
end
