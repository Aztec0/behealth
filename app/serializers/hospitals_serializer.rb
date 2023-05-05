# frozen_string_literal: true

class HospitalsSerializer < ActiveModel::Serializer
  attributes :id, :region, :city, :address, :name, :rating, :tags

  def rating
    object.rating.round(2)
  end
end
