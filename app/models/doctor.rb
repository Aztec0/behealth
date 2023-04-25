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

  belongs_to :hospital, optional: true
  belongs_to :head_doctor, optional: true
  has_many :feedbacks

  scope :by_head_doctor, ->(head_doctor) { where(doctors: { head_doctor_id: head_doctor }) }

  enum :role, %i[doctor head_doctor], _prefix: true, _suffix: true

  validates :email, uniqueness: true
  validates :first_name, presence: true

  # for ransack searching
  def self.ransackable_attributes(_auth_object = nil)
    %w[name surname position hospital_name].freeze
  end

  def self.ransackable_associations(_auth_object = nil)
    ['hospitals']
  end
end
