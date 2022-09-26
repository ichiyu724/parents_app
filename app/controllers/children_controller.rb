class ChildrenController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @child = Child.new
  end

  def create
    @child = Child.new(child_params)
    if @child.save
      flash[:notice] = 'お子さんの情報を登録しました。'
      redirect_to :posts
    else 
      flash.now[:alert] = '登録に失敗しました。'
      render ("children/new")
    end 
  end

  def index
    @user = User.find(params[:user_id])
    @children = Child.all.order(birthdate: :desc).includes(:user)
  end

  def show
    @user = User.find(params[:user_id])
    @child = Child.find(params[:id])
  end
  private

  def child_params
    params.require(:child).permit(:nickname, :gender, :birthdate).merge(user_id: current_user.id)
  end
end
