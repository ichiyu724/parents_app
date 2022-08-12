class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update, :destroy]
  
  def index
    @post_data = Post.all.order(created_at: :desc)
    @posts = Kaminari.paginate_array(@post_data).page(params[:page]).per(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'お悩みを投稿しました'
      redirect_to :posts
    else 
      flash.now[:alert] = '投稿に失敗しました。'
      render ("posts/new")
    end 
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @comment = @post.comments.build(user_id: current_user.id) if current_user
  end

  def image
    @posts = Post.where(user_id: current_user.id).where.not(image: nil)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      flash[:notice]= "投稿を更新しました"
      redirect_to post_path
    else
      flash.now[:alert] = '投稿に失敗しました。'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to :posts
  end

  def search
    index
    render :index
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
