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
#  name                 :string
#  password_digest      :string
#  phone                :bigint
#  reset_password_token :string
#  sex                  :integer          default("nothing")
#  surname              :string
#  tin                  :integer
#  token_sent_at        :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  chat_id              :bigint
#

class Patient < ApplicationRecord
  include Passwordable::Shareable

  has_many :feedbacks
  has_one :patient_address
  has_one :patient_work
  has_one :patient_document

  enum sex: %i[nothing male female] #Перейменувати nothing

  validates :name, :surname, :fathername, format: { with: /\A\p{Cyrillic}+\z/ }, allow_blank: true
  validates :tin, length: { is: 10 }, numericality: { only_integer: true }, allow_blank: true
  validates :email, uniqueness: true

  def contact_info
    { email: email, phone: "+#{phone.to_s}" }
  end

  def main_info
    fullname = [surname, name]
    fullname << fathername if fathername.present?
    { fullname: fullname.join(' '), birthday: birthday.strftime("%d.%m.%Y"), tin: tin, sex: sex }
  end

  #concern Confirmable - перенести токен + email_activate
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
end
