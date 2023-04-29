# frozen_string_literal: true

# == Schema Information
#
# Table name: patients
#
#  id                   :bigint           not null, primary key
#  birthday             :date
#  confirm_token        :string
#  email                :string
#  email_confirmed      :boolean          default(FALSE)
#  fathername           :string
#  itn                  :integer
#  name                 :string
#  password_digest      :string
#  phone                :bigint
#  reset_password_token :string
#  sex                  :integer          default("nothing")
#  surname              :string
#  token_sent_at        :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  chat_id              :bigint
#

class Patient < ApplicationRecord
  include Constantable
  include Passwordable::Shareable
  include Confirmable

  has_many :feedbacks
  has_one :patient_address
  has_one :patient_work
  has_one :patient_document
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments

  enum sex: { nothing: 0, male: 1, female: 2 }

  validates :name, :surname, :fathername, format: { with: NAME_REGEX }, allow_blank: true
  validates :tin, length: { is: TIN_LENGTH }, numericality: { only_integer: true }, allow_blank: true
  validates :email, uniqueness: true

  def contact_info
    { email: email, phone: "+#{phone.to_s}" }
  end

  def main_info
    fullname = "#{surname} #{name} #{fathername unless fathername.nil?}".strip
    { fullname: fullname, birthday: birthday.strftime('%d.%m.%Y'), tin: tin, sex: sex }
  end
end
