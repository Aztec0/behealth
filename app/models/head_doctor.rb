# frozen_string_literal: true

# == Schema Information
#
# Table name: doctors
#
#  id                     :bigint           not null, primary key
#  birthday               :date
#  email                  :string
#  name                   :string
#  password_digest        :string
#  phone                  :bigint
#  position               :string
#  rating                 :integer          default(0)
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("doctor")
#  surname                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  hospital_id            :bigint
#
# Indexes
#
#  index_doctors_on_hospital_id  (hospital_id)
#
# Foreign Keys
#
#  fk_rails_...  (hospital_id => hospitals.id)
#
class HeadDoctor < Doctor
  has_many :doctors, dependent: :destroy
  belongs_to :hospital, optional: true

  scope :by_creation_date, -> { order(created_at: :desc) }
  scope :alphabetically, -> { order(:surname, :name) }
  scope :by_specialization, ->(specialization) { where(position: specialization) }

  has_secure_password

  validates :name, presence: true

  # this part is for create doctor
  def create_doctor(params)
    doctor = Doctor.new(params)
    doctor.hospital = hospital # assign the hospital to the new doctor
    if doctor.save
      doctor.generate_password_token!
      DoctorMailer.with(doctor).temporary_password.deliver_later
      render json: doctor, status: :created
    else
      render json: { error: doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # this method is used to delete doctor
  def delete_doctor(doctor_id)
    doctor = Doctor.find(doctor_id)
    if doctor.destroy
      head :no_content
    else
      render json: { error: doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # this part is for cancel appointment
  def canceled_appointments
    Appointment.cancled
  end
end
