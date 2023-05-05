# frozen_string_literal: true

class Api::V1::ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]
  def index

    @chats = current_user.chats

    render json: @chats
  end

  def show
    render json: @chat
  end

  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render json: @chat, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  def update
    if @chat.update(chat_params)
      render json: @chat, status: :ok
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @chat.destroy
  end

  private

  def set_chat
    @chat = current_user.chats.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:doctor_id, :patient_id)
  end
end
