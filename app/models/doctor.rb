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
#  head_doctor_id       :bigint
#  hospital_id          :bigint
#
# Indexes
#
#  index_doctors_on_head_doctor_id  (head_doctor_id)
#  index_doctors_on_hospital_id     (hospital_id)
#
# Foreign Keys
#
#  fk_rails_...  (head_doctor_id => doctors.id)
#  fk_rails_...  (hospital_id => hospitals.id) ON DELETE => nullify
#

class Doctor < ApplicationRecord
  include Constantable
  belongs_to :hospital, optional: true # потрібно для того , щоб гол.лікар міг створити лікарню, вона потім додається лікарю який її створив

  has_many :feedbacks

  has_secure_password

  scope :list_doctor_by_hospital, ->(current_user) {
    includes(:hospital).where(doctors: { hospital_id: current_user })
  }

  enum :role, %i[doctor head_doctor], _prefix: true, _suffix: true

  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: PASSWORD_MINIMUM_LENGTH }

  def generate_password_token!
    self.reset_password_token = generate_token
    self.token_sent_at = Time.now.utc
    save!
  end

  def token_valid?
    (token_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  def create_doctor(params)
    temp_password = generate_temporary_password
    doctor = Doctor.new(params)
    doctor.password = temp_password
    doctor.generate_password_token!
    doctor.save!

    DoctorMailer.send_temporary_password(doctor, temp_password).deliver_later
    doctor
  end

  private

  def full_name
    "#{surname} #{name} #{second_name}"
  end

  def generate_temporary_password
    SecureRandom.alphanumeric(10)
  end

  def generate_token
    SecureRandom.hex(10)
  end
end
