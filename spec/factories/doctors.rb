# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :doctor do
    email { Faker::Internet.email }
    password { 'password' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    hospital_id { 1 }

    trait :admin do
      role { :admin }
    end

    trait :head_doctor do
      role { :head_doctor }
    end

    trait :with_feedbacks do
      transient do
        feedbacks_count { 5 }
      end

      after(:create) do |doctor, evaluator|
        create_list(:feedback, evaluator.feedbacks_count, doctor: doctor)
      end
    end

    trait :with_appointments do
      transient do
        appointments_count { 5 }
      end

      after(:create) do |doctor, evaluator|
        create_list(:appointment, evaluator.appointments_count, doctor: doctor)
      end
    end

    factory :admin_doctor, traits: [:admin]
    factory :head_doctor, traits: [:head_doctor]
    factory :doctor_with_feedbacks, traits: [:with_feedbacks]
    factory :doctor_with_appointments, traits: [:with_appointments]
    factory :doctor_with_feedbacks_and_appointments, traits: [:with_feedbacks, :with_appointments]
  end
end
