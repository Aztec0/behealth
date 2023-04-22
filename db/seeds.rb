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
