# frozen_string_literal: true

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
  include Constantable

  belongs_to :patient

  validates :place, presence: true, length: { maximum: 100 }, format: { with: WORKPLACE_REGEX }
  validates :position, presence: true, length: { maximum: 15 }, format: { with: POSITION_REGEX }
end
