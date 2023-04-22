# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# HeadDoctor.create(name: 'Андрей', surname: 'Сергеев',
#                   position: 'главный врач', birthday: '1990-01-01',
#                   email: 'test@test.com', password: '123456789',
#                   phone: '79999999999', rating: 5,
#                   role: 1, hospital_id: nil)
# HeadDoctor.create(name: 'Андрей', surname: 'Сергеев',
#                   position: 'главный врач', birthday: '1990-01-01',
#                   email: 'test1@test.com', password: '123456789',
#                   phone: '79999999989', rating: 5,
#                   role: 1, hospital_id: nil)

PatientAddress.create(patient_id: 2, settlement: 'Черкаси', house: '1', apartments: '1', address_type: 'Основний')
PatientWork.create(patient_id: 2, work_type: 'Основна', place: 'Аском', position: 'Монтажник')