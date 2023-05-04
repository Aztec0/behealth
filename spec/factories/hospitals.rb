# frozen_string_literal: true

FactoryBot.define do
  factory :hospital do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    region { Faker::Address.state }
  end
end
