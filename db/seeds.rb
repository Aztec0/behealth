# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Patient.create(name: 'Юзер', surname: 'Тестовий', birthday: '05.11.2003', email: 'testuser@test.rb',
              phone: '+380000000000', password: '11111111')
PatientAddress.create(patient_id: 1, settlement: 'Черкаси', house: '1', apartments: '1', address_type: 'Основний')
PatientAddress.create(patient_id: 1, settlement: 'Червона слобода', house: '1', address_type: 'Додатковий')
PatientWork.create(patient_id: 1, work_type: 'Основна', place: 'Аском', position: 'Монтажник')