# frozen_string_literal: true

# == Schema Information
#
# Table name: doctors
#
#  id                   :bigint           not null, primary key
#  about                :text
#  admission_price      :decimal(, )
#  birthday             :date
#  email                :string
#  email_confirmed      :boolean          default(TRUE)
#  first_name           :string
#  last_name            :string
#  password_digest      :string
#  phone                :bigint
#  position             :string
#  rating               :integer          default(0)
#  reset_password_token :string
#  role                 :integer          default("doctor")
#  second_email         :string
#  second_name          :string
#  second_phone         :bigint
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

class Doctor < ApplicationRecord
  include Constantable
  include Passwordable::Shareable
  include Passwordable::Doctorable
  belongs_to :hospital, optional: true # потрібно для того , щоб гол.лікар міг створити лікарню, вона потім додається лікарю який її створив

  has_many :feedbacks
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments
  has_many :tags, as: :tagable

  scope :list_doctor_by_hospital, ->(current_user) {
    includes(:hospital).where(doctors: { hospital_id: current_user })
  }

  enum :role, %i[doctor head_doctor], _prefix: true, _suffix: true

  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: PASSWORD_MINIMUM_LENGTH }
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
