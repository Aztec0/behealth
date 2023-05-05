# == Schema Information
#
# Table name: calendars
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  doctor_id  :bigint           not null
#  patient_id :bigint           not null
#
# Indexes
#
#  index_calendars_on_doctor_id   (doctor_id)
#  index_calendars_on_patient_id  (patient_id)
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => doctors.id)
#  fk_rails_...  (patient_id => patients.id)
#
require 'rails_helper'

RSpec.describe Calendar, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
