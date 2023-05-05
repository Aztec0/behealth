class Api::V2::AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :update, :cancel, :accept]

  def index
    if params[:upcoming]
      @appointments = current_user.appointments.upcoming.where.not(status: "cancelled").order(appointment_datetime: :asc)
    elsif params[:past]
      @appointments = current_user.appointments.past.where.not(status: "cancelled").order(appointment_datetime: :asc)
    else
      @appointments = current_user.appointments.all.where.not(status: "cancelled").order(appointment_datetime: :asc)
    end

    render json: @appointments
  end

  def show
    render json: @appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def cancel
    @appointment.cancelled!
    render json: { message: 'Appointment cancelled' }
  end

  def accept
    @appointment.planned!
    render json: { message: 'Appointment accepted' }
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_datetime, :status, :doctor_id, :patient_id)
  end
end
