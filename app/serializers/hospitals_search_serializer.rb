# frozen_string_literal: true

class HospitalsSearchSerializer < ActiveModel::Serializer
  attributes :id, :region, :city, :address, :name

end
