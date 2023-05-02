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
class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :appointment_datetime, presence: true
  validate :appointment_in_the_past

  enum status: { cancelled: 0, completed: 1, planned: 2, unconfirmed: 3 }, _default: :unconfirmed, _prefix: true

  scope :upcoming, -> { where(status: ["unconfirmed", "planned"]).where("appointment_datetime >= ?", DateTime.now).order(appointment_datetime: :asc) }
  scope :past, -> { where(status: "completed").where("appointment_datetime < ?", DateTime.now).order(appointment_datetime: :desc) }

  private

  def appointment_in_the_past
    errors.add(:appointment_datetime, "can't be in the past") if appointment_datetime.present? && appointment_datetime < Time.now
  end
end

