# frozen_string_literal: true

module Api
  module V1
    class SearchSerializer < ActiveModel::Serializer
      attributes :hospitals, :doctors


      def hospitals
        object.hospitals.map do |hospital|
          {
            name: hospital.name,
            address: hospital.address,
            city: hospital.city,
            region: hospital.region,
            doctors: hospital.doctors.map do |doctor|
              {
                name: doctor.full_name,
                position: doctor.position,
                rating: doctor.rating
              }
            end
          }
        end
      end

      def doctors
        object.doctors.map do |doctor|
          {
            name: doctor.full_name,
            position: doctor.position,
            rating: doctor.rating,
            hospital: {
              name: doctor.hospital.name,
              address: doctor.hospital.address,
              city: doctor.hospital.city,
              region: doctor.hospital.region
            }
          }
        end
      end
    end
  end
end
