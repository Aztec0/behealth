# frozen_string_literal: true

class HospitalSerializer < ActiveModel::Serializer
  attributes :id, :region, :city, :address, :name, :created_at, :updated_at, :doctor_id
  has_many :doctors
end

