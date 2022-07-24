class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def account
    @user = current_user
    @post = Post.find_by(id: params[:post_id])
    favorites = Favorite.limit(2).order(created_at: :desc).where(user_id: current_user.id).pluck(:post_id)
    @favorite_list = Post.find(favorites)
    @my_posts = @user.posts.order(updated_at: :desc).limit(2).includes(:user)
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
        flash[:notice]= "プロフィールを更新しました"
        redirect_to account_path
    else
        flash.now[:alert] = '更新に失敗しました。'
        render :edit
    end
  end

  def favorites
    @user = User.find(params[:id])
    @post = Post.find_by(id: params[:post_id])
    favorites = Favorite.order(created_at: :desc).where(user_id: current_user.id).pluck(:post_id)
    @favorite_list = Post.find(favorites)
  end

  def my_post
    @user = current_user
    @my_posts = @user.posts.order(updated_at: :desc).includes(:user)
  end
  

  private

  def user_params
    params.require(:user).permit(:icon_image, :username, :profile).merge(id: current_user.id)
  end
end
