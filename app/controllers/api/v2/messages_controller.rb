class Api::V2::MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]

  def index
    render json: @chat.messages
  end

  def show
    render json: @message
  end

  def create
    @message = @chat.messages.build(message_params)
    @message.user = current_user

    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

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
