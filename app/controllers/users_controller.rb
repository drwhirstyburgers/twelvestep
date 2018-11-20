class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :terms

  def index
    @users = User.all
    @chat_room = ChatRoom.new

    if params[:search] == "all"
      @users = User.all
    elsif params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
        if @users.count == 0
          [flash[:alert] = "#{params[:search]} was not found"]
          redirect_to users_path
        end
    elsif current_user.stepper?
      @users = User.where.not(id: current_user.id).where('last_seen > ?',10.minutes.ago).where(role: "seeker")
      @favorites = current_user.favorited_users
    elsif current_user.seeker?
      @users = User.where.not(id: current_user.id).where('last_seen > ?',10.minutes.ago).where(role: "stepper")
      @favorites = current_user.favorited_users
    elsif current_user.admin?
      @users = User.all
      @favorites = current_user.favorited_users
    end      
  end

  def show
    @user = User.find(params[:id])
    @chat_room = ChatRoom.new
  end
end
