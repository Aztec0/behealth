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
  include Passwordable::Shareable
  include Passwordable::Doctorable

  belongs_to :hospital, optional: true #minus optional
  belongs_to :head_doctor, optional: true #треба випиляти
  has_many :feedbacks

  scope :by_head_doctor, ->(head_doctor) { where(doctors: { head_doctor_id: head_doctor }) } #має бути всередині лікарні

  enum :role, %i[doctor head_doctor], _prefix: true, _suffix: true #Краще перейменувати роль doctor
  #Переглянути необхідність моделі head_doctor

  validates :email, uniqueness: true
  validates :name, presence: true

  # for ransack searching
  # #Рекомендовано винести ransack в concern Searchable
  def self.ransackable_attributes(auth_object = nil) #Непотрібний аргумент(maybe)
    %w[name surname position hospital_name].freeze #Потрібно винести в константу
  end

  def self.ransackable_associations(auth_object = nil)
    ['hospitals'] #Потрібно винести в константу
  end
end
