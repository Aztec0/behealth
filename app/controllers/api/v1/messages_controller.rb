class Api::V1::MessagesController < ApplicationController

  # GET /chats/:chat_id/messages
  def index
    chat = current_user.chats.find(params[:chat_id])
    render json: chat.messages
  end

  # POST /chats/:chat_id/messages
  def create
    chat = current_user.chats.find(params[:chat_id])
    message = chat.messages.build(message_params)
    message.user = current_user

    if message.save
      render json: message, status: :created
    else
      render json: message.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content)
  end
end
