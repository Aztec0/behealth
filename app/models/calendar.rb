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
class Calendar < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
end
