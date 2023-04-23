
# HeadDoctor.create(name: 'Андрей', surname: 'Сергеев',
#                  position: 'главный врач', birthday: '1990-01-01',
#                  email: 'test@test.com', password: '123456789',
#                  phone: '79999999999', rating: 5,
#                  role: 1, hospital_id: nil)
# HeadDoctor.create(name: 'Андрей', surname: 'Сергеев',
#                  position: 'главный врач', birthday: '1990-01-01',
#                  email: 'test1@test.com', password: '123456789',
#                  phone: '79999999989', rating: 5,
#                  role: 1, hospital_id: nil)
#10.times do
#  HeadDoctor.create(name: Faker::Name.name, surname: Faker::Name.last_name,
#                    second_name: Faker::Name.last_name, position: Faker::Job.position,
#                    rating: rand(1..5), role: 1, hospital_id: rand(1..10))
#end

# need add validates field like password and etc
#50.times do
#  Doctor.create(name: Faker::Name.name, surname: Faker::Name.last_name,
#                second_name: Faker::Name.last_name, position: Faker::Job.position,
#                rating: rand(1..5), hospital_id: rand(1..10))
#end

50.times do
  Hospital.create(address: Faker::Address.street_address,
                  city: Faker::Address.city,
                  name: Faker::Address.community,
                  region: Faker::Address.state)
end

#PatientAddress.create(patient_id: 1, settlement: 'Черкаси', house: '1', apartments: '1', address_type: 'Основний')
#PatientWork.create(patient_id: 1, work_type: 'Основна', place: 'Аском', position: 'Монтажник')
