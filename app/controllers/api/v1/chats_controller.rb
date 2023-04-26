class ChatsController < ApplicationController
  before_action :authenticate_request
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    @chats = current_user.chats

    render json: @chats
  end

  # GET /chats/:id
  def show
    render json: @chat
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render json: @chat, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PUT /chats/:id
  def update
    if @chat.update(chat_params)
      render json: @chat, status: :ok
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/:id
  def destroy
    @chat.destroy
  end

  private

  def set_chat
    @chat = current_user.chats.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def chat_params
    params.require(:chat).permit(:doctor_id, :patient_id)
  end
end
