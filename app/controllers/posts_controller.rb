class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    
  end

  def create
    @post = Post.new(content: params[:content])
   if @post.save
    flash[:notice] = 'メッセージが送信されました'
    redirect_to("/posts/index")
   else 
    flash.now[:alert] = '投稿に失敗しました。'
    render :index
   end
    
  end
  
  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
