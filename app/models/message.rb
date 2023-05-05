class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :patient
  belongs_to :doctor
end
