class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
        flash[:notice]= "プロフィールを更新しました"
        redirect_to user_path(@user)
    else
        flash.now[:alert] = '更新に失敗しました。'
        render :edit
    end
  end

  def favorites
    @user = User.find(params[:id])
    @post = Post.find_by(id: params[:post_id])
    favorites = Favorite.order(created_at: :desc).where(user_id: @user.id).pluck(:post_id)
    @favorite_list = Post.find(favorites)
  end

  def user_posts
    @user = User.find(params[:id])
    @user_posts = @user.posts.order(updated_at: :desc).includes(:user)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(updated_at: :desc).includes(:user).limit(2)
    favorites = Favorite.limit(2).order(created_at: :desc).where(user_id: @user.id).pluck(:post_id)
    @favorite_list = Post.find(favorites)
  end

  def index 
    @users = User.where.not(id: current_user.id)
  end

  def followings
    @users = User.find(params[:id]).followings
    @user = User.find(params[:id])
  end

  def followers
    @users = User.find(params[:id]).followers
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:icon_image, :username, :profile).merge(id: current_user.id)
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to "/users/#{@user.id}"
    end
  end
end
