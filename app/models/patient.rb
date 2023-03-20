# == Schema Information
#
# Table name: patients
#
#  id              :bigint           not null, primary key
#  birthday        :date
#  email           :string
#  name            :string
#  password_digest :string
#  phone           :bigint
#  surname         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Patient < ApplicationRecord
  has_secure_password

  validates :name, :password, presence: true
end
