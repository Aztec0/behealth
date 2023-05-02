class AppointmentsController < ApplicationController
  # before_action :authenticate_request
  before_action :set_current_user
  before_action :set_appointment, only: [:show, :update, :cancel, :accept]

  # GET /appointments
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

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.status ||= :unconfirmed

    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors.full_messages, status: :unprocessable_entity
    end
  end

  # POST /appointments/1/cancel
  def cancel
    @appointment.cancelled!
    render json: { message: 'Appointment cancelled' }
  end

  # POST /appointments/1/accept
  def accept
    @appointment.planned!
    render json: { message: 'Appointment accepted' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:appointment_datetime, :status, :doctor_id, :patient_id)
  end
end
