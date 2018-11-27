class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :terms
  before_action :choose_role

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
    user = current_user
    chat_rooms = user.chat_rooms
    stepper = User.find_by(username: params[:chat_room][:title])

    chat_rooms.each do |f|
      if f.user_ids.include?(current_user.id) && f.user_ids.include?(stepper.id)
        redirect_to f and return
      end
    end

    @chat_room_new = ChatRoom.new(chat_room_params)
    @chat_room_new.users.push(user, stepper)

    if @chat_room_new.save
      flash[:notice] = "Chat begun!"

      (@chat_room_new.users.uniq - [current_user]).each do |u|
        Notification.create(recipient: u, actor: current_user, action: "started", notifiable: @chat_room_new)
      end

      redirect_to @chat_room_new
    end
  end

  def destroy
    @chat_room = ChatRoom.find(params[:id])

    if @chat_room.destroy
      flash[:notice] = "Chat has been terminated."
      redirect_to chat_rooms_path
    else
      flash[:alert] = "There was an error."
      redirect_to chat_rooms_path
    end
  end

  def help
    @chat_room = ChatRoom.new
    users = User.where.not(id: current_user.id).where(role: "stepper")
    user = users.sample
    @chat_room.users.push(current_user, user)
    @chat_room.title = user.username

    if @chat_room.save
      flash[:notice] = "Chat begun!"

      (@chat_room.users.uniq - [current_user]).each do |u|
        Notification.create(recipient: u, actor: current_user, action: "started", notifiable: @chat_room)
      end

      redirect_to @chat_room
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
