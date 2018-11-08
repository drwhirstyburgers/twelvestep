class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @chat_rooms = @user.chat_rooms
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
    @user = current_user
    @chat_rooms = ChatRoom.all
    stepper = User.where(username: params[:chat_room][:title])

    @chat_rooms.each do |cr|
      if cr.users.includes(@user) && cr.users.includes(stepper)
        redirect_to chat_room_path(cr) and return
      end
    end

    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.users.push(@user, stepper)


    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_room_path(@chat_room)
    else
      redirect_to chat_rooms_path
    end
  end

  def destroy
    @chat_room = ChatRoom.find(params[:id])

    if @chat_room.destroy
      flash[:notice] = "Chat with \"#{@chat_room.title}\" was ended."
      redirect_to chat_rooms_path
    else
      flash[:alert] = "There was an error."
      redirect_to chat_rooms_path
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
