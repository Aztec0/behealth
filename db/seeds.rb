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