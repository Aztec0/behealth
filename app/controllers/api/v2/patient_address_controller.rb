# frozen_string_literal: true

class Api::V2::PatientAddressController < ApplicationController
  before_action :authenticate_patient_user
  before_action :set_address
  before_action :address_check, only: %i[update destroy]

  def create
    return render_error('Address already present', status: :unprocessable_entity) if @address.present?

    address = current_user.build_patient_address(patient_address_params)

    if address.save
      render_success('Address was created successfully!', status: :created)
    else
      render_error(address.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @address.update(patient_address_params)
      render_success('Address was updated successfully')
    else
      render_error('Address cannot be updated', status: :unprocessable_entity)
    end
  end

  def destroy
    if @address.destroy
      render_success('Address was deleted successfully')
    else
      render_error('Address does not exist', status: :bad_request)
    end
  end

  private

  def patient_address_params
    params.permit(:address_type, :settlement, :house, :apartments)
  end

  def set_address
    @address = current_user.patient_address
  end

  def address_check
    render_error('There are no addresses here!') if @address.nil?
  end
end
