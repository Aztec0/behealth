# frozen_string_literal: true

class DoctorsCabinetSerializer < ActiveModel::Serializer
  attributes :tags, :admission_price
  def attributes(*args)
    hash = super
    if @instance_options[:action] == :professional_info
      hash[:price] = object.admission_price
      hash[:position] = object.position
      hash[:hospital_city] = object.hospital.city
      hash[:hospital_region] = object.hospital.region
      hash[:hospital_address] = object.hospital.address
      hash[:hospital_name] = object.hospital.name
    elsif @instance_options[:action] == :personal_info
      hash[:full_name] = "#{object.first_name} #{object.second_name} #{object.last_name}"
      hash[:email] = object.email
      hash[:second_email] = object.second_email
      hash[:phone] = object.phone
      hash[:second_phone] = object.second_phone
      hash[:description] = object.about
    end
    hash
  end
end
