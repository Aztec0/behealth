require File.expand_path('../config/environment', __dir__)

require 'telegram/bot'

token = "5649347186:AAHTqQJ1frE5ZxS5Yz_qzuWsvYlrtbnK0xI"

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when "/start"
      # Send a message to the user asking for their phone number
      bot.api.send_message(chat_id: message.chat.id, text: "Hi! Please enter the phone number you used to register on BeHealth:")

      Patient.create(chat_id: message.chat.id)
    else
      # Look up the user's chat ID in the database
      user = Patient.find_by(phone: message.text.to_i)

      if user && user.phone
        # The user has started the registration process but hasn't entered their phone number yet
        # Update the user's phone number and send a confirmation message
        user.update(chat_id: message.chat.id)
        bot.api.send_message(chat_id: message.chat.id, text: "Thanks! Your phone number has been saved.")
      elsif user && user.phone != message.text.to_i
        # The user has entered their phone number but it doesn't match what's in the database
        bot.api.send_message(chat_id: message.chat.id, text: "Your phone number is incorrect.")
      else
        # The user hasn't started the registration process yet
        bot.api.send_message(chat_id: message.chat.id, text: "Please type /start to begin.")
      end
    end
  end
end