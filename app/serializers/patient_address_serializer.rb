# frozen_string_literal: true

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
class PatientAddressSerializer < ActiveModel::Serializer
  attributes :id, :type, :address_type, :settlement, :house, :apartments

  def type
    'address'
  end
end
