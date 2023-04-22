# frozen_string_literal: true

if @doctor.present?
  json.doctor do
    json.extract! @doctor do |doctor|
      json.name doctor.name
      json.surname doctor.surname
      json.second_name doctor.second_name
      json.position doctor.position
      json.rating doctor.rating
      json.hospitals doctor.hospital.name
    end
  end
end
