class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id]) 
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = '投稿にコメントしました。'
      redirect_back(fallback_location: root_path)
    else
      @comments = @post.comments.includes(:user)
      flash[:alert] = 'コメントを入力してください。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
    flash[:notice] = 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
