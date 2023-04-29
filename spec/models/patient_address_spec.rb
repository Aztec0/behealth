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
require 'rails_helper'

RSpec.describe PatientAddress, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
