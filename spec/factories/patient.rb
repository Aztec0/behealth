# frozen_string_literal: true

FactoryBot.define do
  factory :patient do
    first_name { 'Тест' }
    last_name { 'Тестов' }
    second_name { 'Тестович' }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    password { 'password123' }
    email_confirmed { true }
  end
end
