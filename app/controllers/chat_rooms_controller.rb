class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chat_rooms = ChatRoom.where('user_id=? OR username=?', current_user.id, current_user.username)
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new

    if @chat_room.user_id == current_user.id || @chat_room.username == current_user.username
      @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
      @message = Message.new
    else
      flash[:alert] = "Whoops! You don't belong in there!"
      redirect_to chat_rooms_path
    end
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_rooms = ChatRoom.all

    @chat_rooms.each do |cr|
      if cr.user_id == current_user.id || cr.username == current_user.username
        redirect_to chat_rooms_path and return
      end
    end

    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.user_id = current_user.id

    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_room_path(@chat_room)
    else
      redirect_to chat_rooms_path
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :username)
  end
end
