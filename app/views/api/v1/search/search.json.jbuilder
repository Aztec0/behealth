# frozen_string_literal: true

json.hospitals do
  json.array! @hospitals do |hospital|
    json.name hospital.name
    json.address hospital.address
    json.city hospital.city
    json.region hospital.region

    json.doctors hospital.doctors do |doctor|
      json.extract! doctor, :id, :name, :surname, :position, :rating
    end
  end
end

json.doctors do
  json.array! @doctors do |doctor|
    json.name doctor.name
    json.address doctor.surname
    json.city doctor.position

    json.hospitals doctor.hospital.name
  end
end

