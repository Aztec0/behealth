# frozen_string_literal: true

class CalendarsController < ApplicationController
  # GET /calendar
  def index
    render json: appointments_json
  end

  # POST /calendar
  def create
    appointment = current_user.appointments.build(appointment_params)

    if appointment.save
      render json: { message: 'Appointment created', id: appointment.id }, status: :created
    else
      render json: appointment.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PUT /calendar/:id
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
        start: appointment.appointment_datetime,
        end: appointment.appointment_datetime + 1.hour,
        id: appointment.id,
        status: appointment.status
      }
    end
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:appointment_datetime, :doctor_id, :patient_id)
  end
end
