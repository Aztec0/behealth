class Api::V1::MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]
  # GET /chats/:chat_id/messages
  def index
    chat = current_user.chats.find(params[:chat_id])
    render json: chat.messages
  end

  def show
    render json: @message
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

  # PATCH/PUT /chats/:chat_id/messages/:id
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /chats/:chat_id/messages/:id
  def destroy
    @message.destroy
    head :no_content
  end

  private

  def set_chat
    @chat = current_user.chats.find(params[:chat_id])
  end

  def set_message
    @message = @chat.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end