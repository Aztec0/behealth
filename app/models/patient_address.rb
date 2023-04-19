# == Schema Information
#
# Table name: patient_addresses
#
#  id           :bigint           not null, primary key
#  address_type :string           not null
#  apartments   :string
#  house        :string           not null
#  settlement   :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  patient_id   :bigint           not null
#
# Indexes
#
#  index_patient_addresses_on_patient_id  (patient_id)
#
# Foreign Keys
#
#  fk_rails_...  (patient_id => patients.id)
#
class PatientAddress < ApplicationRecord
  belongs_to :patient

  VALID_SETTLEMENT = /\A[\p{Cyrillic} ,.–();]+\z/

  validates :settlement, presence: true, length: { maximum: 100 }, format: { with: VALID_SETTLEMENT }
  validates :house, presence: true, format: { with: /\A[0-9\/]{1,5}\z/ }
  validates :house, format: { with: /\A[1-9]{1,5}\z/ }
end
