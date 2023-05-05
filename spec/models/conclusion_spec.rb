# == Schema Information
#
# Table name: conclusions
#
#  id             :bigint           not null, primary key
#  text           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  appointment_id :bigint
#  doctor_id      :bigint
#
# Indexes
#
#  index_conclusions_on_appointment_id  (appointment_id)
#  index_conclusions_on_doctor_id       (doctor_id)
#
# Foreign Keys
#
#  fk_rails_...  (appointment_id => appointments.id)
#  fk_rails_...  (doctor_id => doctors.id)
#
require 'rails_helper'

RSpec.describe Conclusion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
