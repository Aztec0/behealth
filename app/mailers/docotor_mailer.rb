# frozen_string_literal: true

class DoctorMailer < ApplicationMailer
  def temporary_password(doctor)
    @doctor = doctor
    mail(to: doctor.email, subject: 'Your temporary password')
  end
end
