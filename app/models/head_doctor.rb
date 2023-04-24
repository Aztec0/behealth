# frozen_string_literal: true

# == Schema Information
#
# Table name: doctors
#
#  id                   :bigint           not null, primary key
#  birthday             :date
#  description          :text
#  email                :string
#  email_confirmed      :boolean          default(TRUE)
#  name                 :string
#  password_digest      :string
#  phone                :bigint
#  position             :string
#  price                :decimal(, )
#  rating               :integer          default(0)
#  reset_password_token :string
#  role                 :integer          default("doctor")
#  second_email         :string
#  second_name          :string
#  second_phone         :bigint
#  surname              :string
#  token_sent_at        :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  hospital_id          :bigint
#
# Indexes
#
#  index_doctors_on_hospital_id  (hospital_id)
#
# Foreign Keys
#
#  fk_rails_...  (hospital_id => hospitals.id) ON DELETE => nullify
#
class HeadDoctor < Doctor
  has_many :doctors, dependent: :nullify
  belongs_to :hospital, optional: true

  scope :by_creation_date, -> { order(created_at: :desc) }
  scope :alphabetically, -> { order(:surname, :name) }
  scope :by_specialization, ->(specialization) { where(position: specialization) }

  has_secure_password

  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def create_doctor(params)
    temp_password = generate_temporary_password
    doctor = Doctor.new(params)
    doctor.password = temp_password
    doctor.generate_password_token!
    doctor.save!

    DoctorMailer.send_temporary_password(doctor, temp_password).deliver_later
    doctor
  end

  # this part is for cancel appointment
  def canceled_appointments
    Appointment.cancled
  end
end
