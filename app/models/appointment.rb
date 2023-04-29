class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :appointment_datetime, presence: true
  validate :appointment_in_the_past

  enum :status, [:cancelled, :completed, :planned, :unconfirmed], default: :unconfirmed

  scope :upcoming, -> { where(status: ["unconfirmed", "planned"]).where("appointment_datetime >= ?", DateTime.now).order(appointment_datetime: :asc) }
  scope :past, -> { where(status: "completed").where("appointment_datetime < ?", DateTime.now).order(appointment_datetime: :desc) }

  private

  def appointment_in_the_past
    errors.add(:appointment_datetime, "can't be in the past") if appointment_datetime.present? && appointment_datetime < Time.now
  end
end
