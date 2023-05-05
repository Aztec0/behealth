class Api::V2::CalendarController < ApplicationController

  def index
    render json: appointments_json
  end

  def create
    appointment = current_user.appointments.build(appointment_params)

    if appointment.save
      render json: { message: 'Appointment created', id: appointment.id }, status: :created
    else
      render json: appointment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    appointment = current_user.appointments.find(params[:id])

    if appointment.update(appointment_params)
      render json: { message: 'Appointment updated' }, status: :ok
    else
      render json: appointment.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def appointments_json
    @current_user.appointments.map do |appointment|
      {
        title: "#{appointment.doctor.name} - #{appointment.patient.name}",
        start_time: appointment.appointment_datetime,
        end_time: appointment.appointment_datetime + 1.hour,
        id: appointment.id,
        status: appointment.status
      }
    end
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_datetime, :doctor_id, :patient_id)
  end
end
