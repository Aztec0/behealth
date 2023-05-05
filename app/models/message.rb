# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :bigint           not null
#  doctor_id  :bigint           not null
#  patient_id :bigint           not null
#
# Indexes
#
#  index_messages_on_chat_id     (chat_id)
#  index_messages_on_doctor_id   (doctor_id)
#  index_messages_on_patient_id  (patient_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#  fk_rails_...  (doctor_id => doctors.id)
#  fk_rails_...  (patient_id => patients.id)
#
class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :patient
  belongs_to :doctor
end
