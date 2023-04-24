# frozen_string_literal: true

# == Schema Information
#
# Table name: passports
#
#  id         :bigint           not null, primary key
#  date       :date
#  issued_by  :string
#  number     :string
#  series     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PassportSerializer < ActiveModel::Serializer
  attributes :id, :type, :series, :number, :issued_by, :date

  def type
    'Passport'
  end
end
