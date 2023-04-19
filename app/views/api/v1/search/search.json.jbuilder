# frozen_string_literal: true

if @hospitals.present?
  json.hospitals do
    json.array! @hospitals do |hospital|
      json.name hospital.name
      json.address hospital.address
      json.city hospital.city
      json.region hospital.region
      json.doctors hospital.doctors do |doctor|
        json.extract! doctor, :name, :surname, :position, :rating
      end
    end
  end
end

if @doctors.present?
  json.doctors do
    json.array! @doctors do |doctor|
      json.name doctor.name
      json.address doctor.surname
      json.position doctor.position
      json.rating doctor.rating
      json.hospitals doctor.hospital.name
    end
  end
end
