# frozen_string_literal: true

module Confirmable
  extend ActiveSupport::Concern

  def generate_confirm_token!
    self.confirm_token = generate_token
    self.token_sent_at = Time.now.utc
    save!(validate: false)
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
