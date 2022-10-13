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
      render("children/new")
    end 
  end

  def index
    @user = current_user
    @children = Child.where(user_id: @user.id).order(birthdate: :asc).includes(:user)
  end

  def show
    @child = Child.find(params[:id])
    @vaccination_schedules = [
      [@child.birthdate + 2.month, "ヒブ １回目", "ロタウイルス １回目", "小児用肺炎球菌 １回目", "Ｂ型肝炎 １回目"],
      [@child.birthdate + 3.month, "ヒブ ２回目", "ロタウイルス ２回目", "小児用肺炎球菌 ２回目", "４種混合 第１期 １回目", "Ｂ型肝炎 ２回目"],
      [@child.birthdate + 4.month, "ヒブ ３回目", "ロタウイルス ３回目", "小児用肺炎球菌 ３回目", "４種混合 第１期 ２回目"],
      [@child.birthdate + 5.month, "４種混合 第１期 ３回目", "BCG"],
      [@child.birthdate + 7.month, "Ｂ型肝炎 ３回目"],
      [@child.birthdate + 12.month, "おたふくかぜ １回目", "ヒブ ４回目", "小児用肺炎球菌 ４回目", "水痘 １回目", "麻しん・風しん混合(MR) 第１期", "４種混合 第１期 ４回目"],
      [@child.birthdate + 18.month, "水痘 ２回目"],
      [@child.birthdate + 36.month, "日本脳炎 第１期 1回目"],
      [@child.birthdate + 37.month, "日本脳炎 第１期 2回目"],
      [@child.birthdate + 49.month, "日本脳炎 第１期 3回目"],
      [@child.pre_school_year(@child.birthdate), "おたふくかぜ ２回目", "麻しん・風しん混合(MR) 第２期" ],
      [@child.birthdate + 9.year, "日本脳炎 第２期"],
      [@child.birthdate + 11.year, "２種混合 第２期"]
    ]
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
      render("children/edit")
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
