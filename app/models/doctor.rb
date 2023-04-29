# frozen_string_literal: true

# == Schema Information
#
# Table name: doctors
#
#  id                   :bigint           not null, primary key
#  birthday             :date
#  email                :string
#  name                 :string
#  password_digest      :string
#  phone                :bigint
#  position             :string
#  rating               :integer          default(0)
#  reset_password_token :string
#  role                 :integer          default("doctor")
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
include Passwordable::Shareable
include Passwordable::Doctorable
belongs_to :hospital, optional: true # потрібно для того , щоб гол.лікар міг створити лікарню, вона потім додається лікарю який її створив

  has_many :feedbacks
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  has_secure_password

scope :list_doctor_by_hospital, ->(current_user) {
  includes(:hospital).where(doctors: { hospital_id: current_user })
}
  enum :role, %i[doctor head_doctor], _prefix: true, _suffix: true

  validates :email, uniqueness: true
  validates :first_name, presence: true

  def create_doctor(params)
    temp_password = generate_temporary_password
    doctor = Doctor.new(params)
    doctor.password = temp_password
    doctor.generate_password_token!
    doctor.save!

    DoctorMailer.send_temporary_password(doctor, temp_password).deliver_later
    doctor
  end
end
