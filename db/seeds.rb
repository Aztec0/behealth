# frozen_string_literal: true

Patient.create(email: 'test@test.rb', password: '11111111', first_name: 'Тест')
Hospital.create(region: 'aaa', city: 'aaa', address: 'aaa', name: 'aaa')
Doctor.create(email: 'test@test.rb', password: '11111111', first_name: 'Тест', last_name: 'Тестовий',
              second_name: 'Тестович', hospital: Hospital.last, email_confirmed: true)
PatientAddress.create(patient_id: 1, settlement: 'Черкаси', house: '1', apartments: '1', address_type: 'Основний')
PatientWork.create(patient_id: 1, work_type: 'Основна', place: 'Аском', position: 'Монтажник')
IdCard.create(number: '123456789', issued_by: '1234', date: '05.05.2023')
PatientDocument.create(patient: Patient.last, document_type: 'IdCard', document_id: IdCard.last.id)
Feedback.create(title: 'Test', body: 'Test', rating: 4, patient: Patient.last, doctorable_type: 'Doctor',
                doctorable_id: Doctor.last.id)
Feedback.create(title: 'Test', body: 'Test', rating: 4, patient: Patient.last, doctorable_type: 'Hospital',
                doctorable_id: Hospital.last.id)
# 10.times do
#   Doctor.create(name: Faker::Name.name, surname: Faker::Name.last_name,
#                     position: 'main doctor', birthday: '1990-01-01',
#                     email: "test_head#{rand(1..10)}@test.com", password: '123456789',
#                     phone: '99999999999', role: 1, hospital_id: rand(1..10))
# end
#
# 40.times do
#   Doctor.create(name: Faker::Name.name, surname: Faker::Name.last_name,
#   second_name: Faker::Name.last_name, position: Faker::Job.position,
#   rating: rand(1..5), hospital_id: rand(1..10), password: SecureRandom.alphanumeric(10),
#   email: "testtest#{rand(1..10)}@test.com")
# end
#
# Hospital.create!(region: 'Вінницький', city: 'Вінниця', address: 'вул. Хмельницьке шосе, 96',
#                  name: 'КОМУНАЛЬНЕ НЕКОМЕРЦІЙНЕ ПІДПРИЄМСТВО “Центр первинної медико-санітарної допомоги №3”')
# Hospital.create!(region: 'Святошинський район', city: 'Київ', address: 'вул. Симиренка, 10', name:
#   'КОМУНАЛЬНЕ НЕКОМЕРЦІЙНЕ ПІДПРИЄМСТВО "КОНСУЛЬТАТИВНО-ДІАГНОСТИЧНИЙ ЦЕНТР" СВЯТОШИНСЬКОГО РАЙОНУ М. КИЄВА')
# Hospital.create!(region: 'Немишлянський район', city: 'Харків', address: 'вул. Олімпійська, 3',
#                  name: 'КОМУНАЛЬНЕ НЕКОМЕРЦІЙНЕ ПІДПРИЄМСТВО "МІСЬКА ПОЛІКЛІНІКА № 5" ХАРКІВСЬКОЇ МІСЬКОЇ РАДИ')
# Hospital.create!(region: 'Галицький район', city: 'Львів', address: 'вул. Руська, 20',
#                  name: 'КОМУНАЛЬНЕ НЕКОМЕРЦІЙНЕ ПІДПРИЄМСТВО "1-А МІСЬКА ПОЛІКЛІНІКА М. ЛЬВОВА"')
# Hospital.create!(region: 'Київський район', city: 'Одеса', address: 'вул. Левітана, 62', name:
#   'КОМУНАЛЬНЕ НЕКОМЕРЦІЙНЕ ПІДПРИЄМСТВО "КОНСУЛЬТАТИВНО-ДІАГНОСТИЧНИЙ ЦЕНТР №20" ОДЕСЬКОЇ МІСЬКОЇ РАДИ')
# Hospital.create!(region: 'Амур-Нижньодніпровський район', city: 'Дніпро', address: 'пров. Фестивальний, 1', name:
#   'КОМУНАЛЬНЕ НЕКОМЕРЦІЙНЕ ПІДПРИЄМСТВО "ДНІПРОВСЬКИЙ ЦЕНТР ПЕРВИННОЇ МЕДИКО-САНІТАРНОЇ ДОПОМОГИ №9" ДНІПРОВСЬКОЇ МІСЬКОЇ РАДИ')
# Hospital.create!(region: 'Хортицький район', city: 'Запоріжжя', address: 'вул. Запорізького Козацтва, 25', name:
#   'КОМУНАЛЬНЕ НЕКОМЕРЦІЙНЕ ПІДПРИЄМСТВО "ЗАПОРІЗЬКИЙ ЦЕНТР ПЕРВИННОЇ МЕДИКО-САНІТАРНОЇ ДОПОМОГИ № 5"')
# Hospital.create!(region: 'Деснянський район', city: 'Чернігів', address: 'вул. Шевченка 114', name:
#   'КОМУНАЛЬНЕ НЕКОМЕРЦІЙНЕ ПІДПРИЄМСТВО "ЧЕРНІГІВСЬКИЙ РАЙОННИЙ ЦЕНТР ПЕРВИННОЇ МЕДИКО-САНІТАРНОЇ ДОПОМОГИ"')
# Hospital.create!(region: 'Придніпровський район', city: 'Черкаси', address: "вулиця В'ячеслава Чорновола, 1", name:
#   'КОМУНАЛЬНЕ НЕКОМЕРЦІЙНЕ ПІДПРИЄМСТВО «Другий Черкаський міський центр первинної медико-санітарної допомоги»')
# Hospital.create!(region: 'Суворовський район', city: 'Херсон', address: 'проспект 200-річчя Херсона, 25', name:
#   'Комунального некомерційного підприємства "Херсонська міська клінічна Лікарня ім. А. і О. Тропіних"')
#
# patient1 = Patient.create(name: 'Human', surname: 'Тестовий', birthday: '05.11.2003', email: 'testuser@test.rb',
#               phone: '+380000000000', password: '11111111')
# doctor1 = Doctor.create(name: 'John Smith', email: 'example@example.com', password: 'password')
# appointment1 = Appointment.create(
#   appointment_datetime: DateTime.now + 1.day,
#   doctor: doctor1,
#   patient: patient1,
#   status: "planned"
# )
# Calendar.create(
#   title: "John Smith - Human",
#   start: DateTime.now + 1.day,
#   end: DateTime.now + 1.day + 1.hour,
#   appointment: Appointment.first
# )

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
