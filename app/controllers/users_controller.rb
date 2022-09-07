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
        flash[:alert] = @user.errors.full_messages
        redirect_to edit_user_path(@user)
    end
  end

  def favorites
    @user = User.find(params[:id])
    @post = Post.find_by(id: params[:post_id])
    favorites = Favorite.order(created_at: :desc).where(user_id: @user.id).pluck(:post_id)
    @favorite_data = Post.find(favorites)
    @favorite_list = Kaminari.paginate_array(@favorite_data).page(params[:page]).per(10)
  end

  def user_posts
    @user = User.find(params[:id])
    @user_posts_data = @user.posts.order(updated_at: :desc).includes(:user)
    @user_posts = Kaminari.paginate_array(@user_posts_data).page(params[:page]).per(10)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(updated_at: :desc).includes(:user).limit(2)
    favorites = Favorite.limit(2).order(created_at: :desc).where(user_id: @user.id).pluck(:post_id)
    @favorite_list = Post.find(favorites)
  end

  def index 
    @user_data = User.where.not(id: current_user.id)
    @users = Kaminari.paginate_array(@user_data).page(params[:page]).per(10)
  end

  def followings
    @user_data = User.find(params[:id]).followings
    @users = Kaminari.paginate_array(@user_data).page(params[:page]).per(10)
    @user = User.find(params[:id])
  end

  def followers
    @user_data = User.find(params[:id]).followers
    @users = Kaminari.paginate_array(@user_data).page(params[:page]).per(7)
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
