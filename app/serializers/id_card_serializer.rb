class IdCardSerializer < ActiveModel::Serializer
  attributes :id, :type, :number, :issued_by, :date

  def type
    'IdCard'
  end
end