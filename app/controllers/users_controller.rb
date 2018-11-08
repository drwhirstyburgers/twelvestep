class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
    @favorites = current_user.favorited_users
    @chat_room = ChatRoom.new
  end

  def show
    @user = User.find(params[:id])
    @chat_room = ChatRoom.new
  end
end
