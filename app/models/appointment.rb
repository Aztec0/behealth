# frozen_string_literal: true

# == Schema Information
#
# Table name: appointments
#
#  id                   :bigint           not null, primary key
#  appointment_datetime :datetime
#  status               :string
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
class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :appointment_datetime, presence: true
  validate :appointment_in_the_past

  enum :status, [:cancelled, :completed, :planned, :unconfirmed], default: :unconfirmed

  scope :upcoming, -> { where(status: ["unconfirmed", "planned"]).where("appointment_datetime >= ?", DateTime.now).order(appointment_datetime: :asc) }
  scope :past, -> { where(status: "completed").where("appointment_datetime < ?", DateTime.now).order(appointment_datetime: :desc) }
  scope :staff_appointments, ->(hospital_id) {
    includes(:doctor).where(doctors: { hospital_id: hospital_id })
  }

  private

  def appointment_in_the_past
    errors.add(:appointment_datetime, "can't be in the past") if appointment_datetime.present? && appointment_datetime < Time.now
  end
end
