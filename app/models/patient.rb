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
#  itn                  :integer
#  last_name            :string
#  password_digest      :string
#  phone                :bigint
#  reset_password_token :string
#  second_name          :string
#  sex                  :integer          default("nothing")
#  token_sent_at        :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  chat_id              :bigint
#

class Patient < ApplicationRecord
  require 'securerandom'

  has_secure_password

  has_many :feedbacks
  has_one :patient_address
  has_one :patient_work
  has_one :patient_document

  enum sex: { nothing: 0, male: 1, female: 2 }

  validates :name, :surname, :fathername, format: { with: /\A\p{Cyrillic}+\z/ }, allow_blank: true
  validates :itn, length: { is: 10 }, numericality: { only_integer: true }, allow_blank: true
  validates :email, uniqueness: true

  def contact_info
    { email: email, phone: "+#{phone}" }
  end

  def main_info
    fullname = "#{surname} #{name} #{fathername unless fathername.nil?}".strip
    { fullname: fullname, birthday: birthday.strftime('%d.%m.%Y'), itn: itn, sex: sex }
  end

  def generate_confirm_token!
    self.confirm_token = generate_token
    self.token_sent_at = Time.now.utc
    save!
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

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

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
