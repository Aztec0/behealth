# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
patient1 = Patient.create(name: 'Human', surname: 'Тестовий', birthday: '05.11.2003', email: 'testuser@test.rb',
              phone: '+380000000000', password: '11111111')
doctor1 = Doctor.create(name: 'John Smith', email: 'example@example.com', password: 'password')
appointment1 = Appointment.create(
  appointment_datetime: DateTime.now + 1.day,
  doctor: doctor1,
  patient: patient1,
  status: "planned"
)
Calendar.create(
  title: "John Smith - Human",
  start: DateTime.now + 1.day,
  end: DateTime.now + 1.day + 1.hour,
  appointment: Appointment.first
)
# frozen_string_literal: true

# if need uncomit
# need add validates field like password and etc
#10.times do
#  Hospital.create(address: Faker::Address.street_address,
#                  city: Faker::Address.city,
#                  name: Faker::Address.community,
#                  region: Faker::Address.state)
#end

#10.times do
#  Doctor.create(name: Faker::Name.name, surname: Faker::Name.last_name,
#                    position: 'main doctor', birthday: '1990-01-01',
#                    email: "test_head#{rand(1..10)}@test.com", password: '123456789',
#                    phone: '79999999999', role: 1, hospital_id: rand(1..10))
#end

#10.times do
#  Doctor.create(name: Faker::Name.name, surname: Faker::Name.last_name,
#  second_name: Faker::Name.last_name, position: Faker::Job.position,
#  rating: rand(1..5), hospital_id: rand(1..10), password: SecureRandom.alphanumeric(10),
#  email: "testtest#{rand(1..10)}@test.com")
#end

#PatientAddress.create(patient_id: 1, settlement: 'Черкаси', house: '1', apartments: '1', address_type: 'Основний')
#PatientWork.create(patient_id: 1, work_type: 'Основна', place: 'Аском', position: 'Монтажник')
