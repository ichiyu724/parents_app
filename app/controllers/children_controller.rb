class ChildrenController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @child = Child.new
  end

  def create
    @child = Child.new(child_params)
    if @child.save
      flash[:notice] = 'お子さんの情報を登録しました。'
      redirect_to user_children_path
    else 
      flash.now[:alert] = '登録に失敗しました。'
      render ("children/new")
    end 
  end

  def index
    @user = current_user
    @children = Child.where(user_id: @user.id).order(birthdate: :asc).includes(:user)
  end

  def show
    @child = current_user.children.find(params[:id])
    vaccines = Vaccination.create(name: JpVaccination.find('hib_1').name, period: JpVaccination.find('hib_1').period, key: 'hib_1')
    @vaccinations = vaccines
  end

  def edit
    @child = Child.find(params[:id])
  end

  def update
    @child = Child.find(params[:id])
    if @child.update(child_params)
      flash[:notice] = 'お子さんの情報を更新しました。'
      redirect_to "/users/#{@child.user_id}/children"
    else 
      flash.now[:alert] = '登録に失敗しました。'
      render ("children/edit")
    end
  end

  def destroy
    @child = Child.find_by(id: params[:id])
    @child.destroy
    flash[:notice] = '登録を解除しました。'
    redirect_to user_children_path
  end

  private

  def child_params
    params.require(:child).permit(:nickname, :gender, :birthdate).merge(user_id: current_user.id)
  end
end
