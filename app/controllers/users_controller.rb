class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :fine_print_require

  def index
    @users = User.all
    @chat_room = ChatRoom.new

    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
        if @users.count == 0
          [flash[:alert] = "#{params[:search]} was not found"]
          redirect_to users_path
        end
    else
      @users = User.where.not(id: current_user.id).where('last_seen > ?',10.minutes.ago)
      @favorites = current_user.favorited_users
    end
  end

  def show
    @user = User.find(params[:id])
    @chat_room = ChatRoom.new
  end
end
