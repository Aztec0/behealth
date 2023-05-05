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
class Conclusion < ApplicationRecord
  belongs_to :doctor
  belongs_to :appointment

  validates  :doctor, :appointment, presence: true
  validates  :text, presence: true, length: { minimum: 1 }

end
