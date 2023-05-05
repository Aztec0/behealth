# frozen_string_literal: true

class Api::V2::DoctorsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]
  before_action :authenticate_doctor_user, except: %i[index]
  before_action :authorize_request, except: %i[index]

  def index
    @pagy, doctors = pagy(Doctor.all)
    render_success({ doctors: ActiveModelSerializers::SerializableResource.new(doctors,
                                                                               each_serializer: DoctorShowSerializer) })
  end

  # in progress
  def staff_appointments
    @pagy, appointments = pagy(Appointment.staff_appointments(current_user.hospital_id))
    render_success({ appointments: ActiveModelSerializers::SerializableResource.new(appointments,
                                                                                    each_serializer: AppointmentSerializer) })
  end

  def create_doctor
    doctor = Doctor.create_doctor(doctor_params.merge(hospital_id: current_user.hospital_id))
    if doctor.save!
      render_success({ doctor: })
    else
      render_error('Unable to create doctor', status: :unprocessable_entity)
    end
  end

  def delete_doctor
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
      render_success({ doctors: ActiveModelSerializers::SerializableResource.new(doctors,
                                                                                 each_serializer: DoctorByHospitalSerializer) })
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

  def authorize_request
    authorize Doctor
  end
end
