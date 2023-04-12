# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint           not null, primary key
#  body       :text
#  rating     :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  doctor_id  :bigint           not null
#  patient_id :bigint           not null
#
# Indexes
#
#  index_feedbacks_on_doctor_id   (doctor_id)
#  index_feedbacks_on_patient_id  (patient_id)
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => doctors.id)
#  fk_rails_...  (patient_id => patients.id)
#
class Feedback < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient, optional: true
end
