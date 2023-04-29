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
class PatientWorkSerializer < ActiveModel::Serializer
  attributes :id, :type, :work_type, :place, :position

  def type
    'work'
  end
end
