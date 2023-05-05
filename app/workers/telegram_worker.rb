# frozen_string_literal: true

class TelegramWorker
  include Sidekiq::Worker
  require 'telegram/bot'

  def perform
    appointments = Appointment.where('appointment_datetime >= ?', Time.current).and(Appointment.where('appointment_datetime <= ?', 2.days.from_now))
    bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])

    appointments.each do |a|
      message = "Appointment with #{a.doctor.first_name} for #{a.patient.first_name} on #{a.appointment_datetime.to_fs(:long)}"
      bot.api.send_message(chat_id: a.patient.chat_id, text: message)
    end
  end
end
