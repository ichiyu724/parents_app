class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @user_id = current_user.id
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'メッセージが送信されました'
      redirect_to :posts
    else 
      flash.now[:alert] = '投稿に失敗しました。'
      render :posts
    end 
  end
  
  def show
    @post = Post.find_by(id: params[:id])
  end

  def image
    @posts = Post.where(user_id: current_user.id).where.not(image: nil)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to :posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :child_sex, :child_age_year, :child_age_month, :content, :content_image).merge(user_id: current_user.id)
  end

  def ensure_user
    @posts = current_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to :posts unless @post
  end
end
