class FavoritesController < ApplicationController
  def create
    user = current_user
    favorited_user = User.find(params[:user_id])
    if user.favorited_users.include?(favorited_user)
      flash[:alert] = "#{favorited_user.username} already favorited!"
      redirect_to users_path
    else
      user.favorited_users << favorited_user
      flash[:notice] = '#{favorited_user.username} favorited!'
      redirect_to users_path
    end
  end

  def destroy
    user = User.find(params[:user_id])

    if current_user.favorited_users.destroy(user.id)
      flash[:notice] = "#{user.username} unfavorited!"
      redirect_to users_path
    else
      flash[:alert] = "There was an error."
      redirect_to users_path
    end
  end
end
