# == Schema Information
#
# Table name: patient_works
#
#  id         :bigint           not null, primary key
#  place      :string           not null
#  position   :string           not null
#  work_type  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  patient_id :bigint           not null
#
require 'rails_helper'

RSpec.describe PatientWork, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
