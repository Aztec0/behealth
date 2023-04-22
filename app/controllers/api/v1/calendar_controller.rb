class CalendarController < ApplicationController
  before_action :authenticate_request

  # GET /calendar
  def index
    events = current_doctor_or_patient.appointments.map do |appointment|
      {
        title: "#{appointment.doctor.name} - #{appointment.patient.name}",
        start: appointment.appointment_datetime,
        end: appointment.appointment_datetime + 1.hour,
        id: appointment.id,
        status: appointment.status
      }
    end

    render json: events
  end

  # POST /calendar
  def create
    appointment = current_doctor_or_patient.appointments.build(appointment_params)

    if appointment.save
      render json: { message: 'Appointment created', id: appointment.id }, status: :created
    else
      render json: appointment.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PUT /calendar/:id
  def update
    appointment = current_doctor_or_patient.appointments.find(params[:id])

    if appointment.update(appointment_params)
      render json: { message: 'Appointment updated' }, status: :ok
    else
      render json: appointment.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:appointment_datetime, :doctor_id, :patient_id)
  end
end
