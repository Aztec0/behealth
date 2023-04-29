# frozen_string_literal: true

class DoctorMailer < ApplicationMailer
  def send_temporary_password(doctor, temp_password)
    @doctor = doctor
    @temp_password = temp_password
    mail(to: doctor.email, subject: 'Welcome to BeHealth! Your temporary password is ready.')
  end
end
