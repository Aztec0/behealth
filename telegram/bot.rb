# frozen_string_literal: true

require File.expand_path('../config/environment', __dir__)

require 'telegram/bot'

token = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      # Send a message to the user asking for their phone number
      bot.api.send_message(chat_id: message.chat.id,
                           text: 'Hi! Please enter the phone number you used to register on BeHealth:')
      bot.listen do |message|
        user = Patient.find_by(phone: message.text.to_i)
        if user&.phone
          # The user has started the registration process but hasn't entered their phone number yet
          # Update the user's phone number and send a confirmation message
          user.update(chat_id: message.chat.id)
          bot.api.send_message(chat_id: message.chat.id, text: 'Thanks! Your phone number has been saved.')
          break
        else
          # The user hasn't started the registration process yet
          bot.api.send_message(chat_id: message.chat.id, text: 'Please type /start to begin.')
          break
        end
      end
    when '/all'
      patient = Patient.find_by(chat_id: message.chat.id)
      appointments = patient.appointments
      if appointments.present?
        appointments.each do |a|
          bot.api.send_message(chat_id: patient.chat_id, text: "дата і час запису: #{a.appointment_datetime};
Статус: #{a.status};
Лікар: #{Doctor.find_by(id: a.doctor_id).first_name} #{Doctor.find_by(id: a.doctor_id).last_name};
Адреса лікарні: #{Doctor.find_by(id: a.doctor_id).hospital.address}")
        end
      end
    when "/closest"
      patient = Patient.find_by(chat_id: message.chat.id)
      appointments = patient.appointments.where("appointment_datetime >= ?", Time.current).order("created_at DESC").first
      bot.api.send_message(chat_id: patient.chat_id, text: "Найближчий запис: #{appointments.appointment_datetime};
Статус: #{appointments.status};
Лікар: #{Doctor.find_by(id: appointments.doctor_id).first_name} #{Doctor.find_by(id: appointments.doctor_id).last_name};
Адреса лікарні: #{Doctor.find_by(id: appointments.doctor_id).hospital.address}")
    end
  end
end
