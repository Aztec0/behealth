class PasswordMailer < ApplicationMailer
  def test_mailer(doctor)
    @doctor = doctor
    mail(to: @doctor.email, subject: 'Welcome to My Awesome Site')
  end
end
