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
class PatientWork < ApplicationRecord
  belongs_to :patient

  VALID_PLACE = /\A[\p{Cyrillic} ,.–();]+\z/
  VALID_POSITION = /\A\p{Cyrillic}+\z/

  validates :place, presence: true, length: { maximum: 100 }, format: { with: VALID_PLACE }
  validates :position, presence: true, length: { maximum: 15 }, format: { with: VALID_POSITION }
end
