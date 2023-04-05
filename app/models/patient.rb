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
#  name                 :string
#  password_digest      :string
#  phone                :bigint
#  reset_password_token :string
#  surname              :string
#  token_sent_at        :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Patient < ApplicationRecord
  has_secure_password

  has_many :feedbacks

  validates :email, uniqueness: true

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
    (self.token_sent_at + 4.hours) > Time.now.utc
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
