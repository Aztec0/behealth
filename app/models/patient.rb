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
#  first_name           :string
#  last_name            :string
#  password_digest      :string
#  phone                :bigint
#  reset_password_token :string
#  second_name          :string
#  sex                  :integer          default("nothing")
#  tin                  :integer
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
  has_many :messages
  has_many :chats
  has_one :patient_address
  has_one :patient_work
  has_one :patient_document
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments

  enum sex: %i[nothing male female]

  validates :first_name, :last_name, :second_name, format: { with: NAME_REGEX }, allow_blank: true
  validates :tin, length: { is: TIN_LENGTH }, numericality: { only_integer: true }, allow_blank: true
  validates :email, uniqueness: true

  def contact_info
    { email: email, phone: "+#{phone.to_s}" }
  end

  def main_info
    birthday = self.birthday.present? ? self.birthday.strftime('%d.%m.%Y') : nil
    { name: first_name, surname: last_name, second_name: second_name, birthday: birthday, tin: tin, sex: sex }
  end
end
