# frozen_string_literal: true

class HospitalsSearchSerializer < ActiveModel::Serializer
  attributes :id, :region, :city, :address, :name, :rating

  def rating
    object.rating.round(2)
  end
end
