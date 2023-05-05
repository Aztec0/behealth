# frozen_string_literal: true

class Api::V2::PatientWorkController < ApplicationController
  before_action :authenticate_patient_user
  before_action :set_work
  before_action :work_check, only: %i[update destroy]

  def create
    return render_error('Work already present', status: :unprocessable_entity) if @work.present?

    work = current_user.build_patient_work(patient_work_params)

    if work.save
      render_success('Work was created successfully!', status: :created)
    else
      render_error(record.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @work.update(patient_work_params)
      render_success('Work was updated successfully')
    else
      render_error('Work cannot be updated', status: :unprocessable_entity)
    end
  end

  def destroy
    if @work.destroy
      render_success('Work was deleted successfully', status: :ok)
    else
      render_error('Work does not exist', status: :bad_request)
    end
  end

  private

  def patient_work_params
    params.permit(:work_type, :place, :position)
  end

  def set_work
    @work = current_user.patient_work
  end

  def work_check
    render_error('There are no works here!') if @work.nil?
  end
end
