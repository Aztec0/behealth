# frozen_string_literal: true

class HospitalsSerializer < ActiveModel::Serializer
  attributes :id, :region, :city, :address, :name, :tags

end
