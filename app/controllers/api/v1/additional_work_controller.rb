class Api::V1::AdditionalWorkController < ApplicationController
  before_action :authenticate_patient_user
  # позбутись тернарні оператори(6-8)

  def index
    work = current_user.patient_work.nil? ? 'undefined' : PatientWorkSerializer.new(current_user.patient_work)

    render json: { address: address, workPlace: work, preferenceCategories: 'undefined' }
  end

  def create
      if current_user.patient_work.nil?
        record = current_user.build_patient_work(patient_work_params)
      else
        render json: {message: 'Work already present'}, status: :unprocessable_entity and return
      end

    if record.save
      render json: { status: 'SUCCESS', message: "#{params[:type].capitalize} was created successfully!",
                     data: record }, status: :created
    else
      render json: record.errors, status: :unprocessable_entity
    end
  end

  def update
    unless current_user.nil?
      case params[:type].downcase
      when 'address'
        address = current_user.patient_address
        unless address.nil?
          if address.update(patient_address_params)
            render json: { message: 'Address was updated successfully', data: address }, status: :ok
          else
            render json: { message: 'Address cannot be updated' }, status: :unprocessable_entity
          end
        else
          render json: {message: 'There are no addresses here!'}, status: :not_found
        end
      when 'work'
        work = current_user.patient_work
        unless work.nil?
          if work.update(patient_work_params)
            render json: { message: 'Work was updated successfully', data: work }, status: :ok
          else
            render json: { message: 'Work cannot be updated' }, status: :unprocessable_entity
          end
        else
          render json: {message: 'There are no works here!'}, status: :not_found
        end
      else
        render json: {message: 'Type is invalid'}, status: :unprocessable_entity
      end
    end
  end

  def destroy
    unless current_user.nil?
      case params[:type].downcase
      when 'address'
        record = current_user.patient_address
      when 'work'
        record = current_user.patient_work
      else
        render json: {message: 'Type is invalid'}, status: :unprocessable_entity and return
      end

      unless record.nil?
        if record.patient == current_user
          if record.destroy
            render json: { message: "#{params[:type].capitalize} was deleted successfully" }, status: :ok
          else
            render json: { message: "#{params[:type].capitalize}  does not exist" }, status: :bad_request
          end
        end
      else
        render json: { message: "There are no #{params[:type].downcase == 'address' ? 'addresses' : 'works'} here!" },
               status: :not_found
      end
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