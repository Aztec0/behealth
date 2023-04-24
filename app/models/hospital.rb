# frozen_string_literal: true

# == Schema Information
#
# Table name: hospitals
#
#  id         :bigint           not null, primary key
#  address    :string
#  city       :string
#  name       :string
#  region     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  doctor_id  :bigint
#
# Indexes
#
#  index_hospitals_on_doctor_id  (doctor_id)
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => doctors.id) ON DELETE => nullify
#
class Hospital < ApplicationRecord
  has_many :doctors

  scope :list_doctor_by_hospital, ->(current_user) { where(doctors: { hospital_id: current_user }) }
end
