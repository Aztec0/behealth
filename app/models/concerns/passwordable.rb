# frozen_string_literal: true

module Passwordable
  module Shareable
    extend ActiveSupport::Concern

    included do
      has_secure_password
    end

    def generate_password_token!
      self.reset_password_token = generate_token
      self.token_sent_at = Time.now
      save!(validate: false)
    end

    def token_valid?
      (token_sent_at + 4.hours) > Time.now
    end

    def reset_password!(password)
      self.reset_password_token = nil
      self.password = password
      save!
    end

    private

    def generate_token
      SecureRandom.hex(10)
    end
  end

  module Doctorable
    extend ActiveSupport::Concern

    included do
      validates :password, presence: true, length: { minimum: 6 }
    end

    def generate_temporary_password
      SecureRandom.alphanumeric(10)
    end
  end
end
