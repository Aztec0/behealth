# frozen_string_literal: true

if @hospital.present?
  json.hospital do
    json.array! @hospital do |hospital|
      json.name hospital.name
      json.address hospital.address
      json.city hospital.city
    end
  end
end
