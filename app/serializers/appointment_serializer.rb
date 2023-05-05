# frozen_string_literal: true

# == Schema Information
#
# Table name: appointments
#
#  id                   :bigint           not null, primary key
#  appointment_datetime :datetime
#  status               :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  doctor_id            :bigint           not null
#  patient_id           :bigint           not null
#
# Indexes
#
#  index_appointments_on_doctor_id   (doctor_id)
#  index_appointments_on_patient_id  (patient_id)
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => doctors.id)
#  fk_rails_...  (patient_id => patients.id)
#
class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :appointment_datetime, :status, :doctor_full_name, :hospital_name, :patient_full_name
end
