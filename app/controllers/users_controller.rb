class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id).where('last_seen > ?',10.minutes.ago)
    @favorites = current_user.favorited_users
    @chat_room = ChatRoom.new
  end

  def show
    @user = User.find(params[:id])
    @chat_room = ChatRoom.new
  end
end
