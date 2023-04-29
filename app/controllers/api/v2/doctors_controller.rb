# frozen_string_literal: true

class Api::V2::DoctorsController < ApplicationController
  before_action :authenticate_request, except: %i[index]
  before_action :authorize_request, except: %i[index]

  def index
    @pagy, doctors = pagy(Doctor.all)
    render_success(DoctorSerializer.new(doctors))
  end

  # in progress
  def staff_appointments
    # this part will be refactor to scop in appointment model
    @pagy, appointments = pagy(Appointment.staff_appointments(current_user.hospital_id))

    scope :staff_appointments, ->(hospital_id) {
      includes(:doctors).where(doctors: { hospital_id: hospital_id })
    }
    render_success(AppointmentSerializer.new(appointments))
  end

  def create_hospital
    if current_user.hospital.present?
      if current_user.hospital.update(hospital_params)
        render_success('Hospital update successful')
      else
        render_error('Unable to update hospital', status: :unprocessable_entity)
      end
    else
      hospital = Hospital.new(hospital_params)
      if hospital.save
        current_user.update(hospital_id: hospital.id)
        render_success('Hospital created successfully')
      else
        render_error('Unable to create hospital', status: :unprocessable_entity)
      end
    end
  end

  def create_doctor
    doctor = current_user.create_doctor(doctor_params.merge(hospital_id: current_user.hospital_id))
    if doctor.save!
      render_success('Doctor created successfully')
    else
      render_error('Unable to create doctor', status: :unprocessable_entity)
    end
  end

  def delete
    doctor = Doctor.find_by(id: params[:id])
    if doctor.present? && doctor.hospital_id == current_user.hospital_id && current_user.id != doctor.id
      doctor.destroy
      render_success('Doctor deleted successfully')
    else
      render_error('Unable to delete doctor', status: :unprocessable_entity)
    end
  end

  def list_doctor_by_hospital
    @pagy, doctors = pagy(Doctor.list_doctor_by_hospital(current_user.hospital_id))
    if doctors
      render_success(DoctorSerializer.new(doctors))
    else
      render_error('Unable to fetch doctors', status: :unprocessable_entity)
    end
  end

  private

  def doctor_params
    params.permit(
      :name, :surname, :second_name, :email, :phone, :birthday, :position,
      :hospital_id
    )
  end

  def hospital_params
    params.permit(:address, :city, :name, :region)
  end

  def authorize_request
    authorize Doctor
  end
end
