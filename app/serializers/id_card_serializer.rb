# frozen_string_literal: true

# == Schema Information
#
# Table name: id_cards
#
#  id         :bigint           not null, primary key
#  date       :date
#  issued_by  :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class IdCardSerializer < ActiveModel::Serializer
  attributes :id, :type, :number, :issued_by, :date

  def type
    'IdCard'
  end
end
