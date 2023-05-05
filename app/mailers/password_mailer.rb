# frozen_string_literal: true

class PasswordMailer < ApplicationMailer
  def test_mailer(user, user_type)
    @user = user
    @user_type = user_type
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
