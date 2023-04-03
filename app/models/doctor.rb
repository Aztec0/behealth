# == Schema Information
#
# Table name: doctors
#
#  id                     :bigint           not null, primary key
#  birthday               :date
#  email                  :string
#  name                   :string
#  password_digest        :string
#  phone                  :bigint
#  position               :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("doctor")
#  surname                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  hospital_id            :bigint           not null
#
# Indexes
#
#  index_doctors_on_hospital_id  (hospital_id)
#
# Foreign Keys
#
#  fk_rails_...  (hospital_id => hospitals.id)
#

class Doctor < ApplicationRecord
  require 'securerandom'

  belongs_to :hospital
  belongs_to :head_doctor, optional: true

  has_secure_password

  enum :role, %i[admin doctor head_doctor]

  validates :name, presence: true

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
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
