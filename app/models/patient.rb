# == Schema Information
#
# Table name: patients
#
#  id              :bigint           not null, primary key
#  birthday        :date
#  email           :string
#  fathername      :string
#  itn             :integer
#  name            :string
#  password_digest :string
#  phone           :bigint
#  sex             :integer          default("nothing")
#  surname         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Patient < ApplicationRecord
  has_secure_password

  has_many :feedbacks
  has_one :patient_address
  has_one :patient_work
  has_one :patient_document
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments

  enum sex: %i[nothing male female]

  validates :name, :password, presence: true
  validates :itn, length: { is: 10 }, numericality: { only_integer: true }, allow_blank: true

  def contact_info
    { email: email, phone: "+#{phone.to_s}" }
  end

  def main_info
    fullname = "#{surname} #{name} #{fathername unless fathername.nil?}".strip
    {fullname: fullname, birthday: birthday.strftime("%d.%m.%Y"), itn: itn, sex: sex}
  end
end
