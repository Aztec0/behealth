class PassportSerializer < ActiveModel::Serializer
  attributes :id, :type, :series, :number, :issued_by, :date

  def type
    'Passport'
  end
end