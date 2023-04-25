# frozen_string_literal: true

class PatientMailer < ApplicationMailer
  def registration(patient)
    @patient = patient
    mail(to: patient.email, subject: 'Welcome to My App')
  end
end
