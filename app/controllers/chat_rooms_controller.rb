class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chat_rooms = current_user.chat_rooms
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new

    if @chat_room.users.includes(current_user)
      @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
      @message = Message.new
    else
      flash[:alert] = "Whoops! You don't belong in there!"
      redirect_to chat_rooms_path
    end
  end

  def create
    @chat_rooms = ChatRoom.all
    @other_user = params[:chat_room][:user]

    @chat_rooms.each do |cr|
      if cr.users.includes(current_user)  && cr.users.includes(@other_user)
        redirect_to chat_room_path(cr) and return
      end
    end

    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.users << current_user

    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_room_path(@chat_room)
    else
      redirect_to chat_rooms_path
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :users)
  end
end
