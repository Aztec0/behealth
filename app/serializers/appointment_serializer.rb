# frozen_string_literal: true

class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :appointment_datetime, :status, :doctor_full_name, :hospital_name, :patient_full_name
end
