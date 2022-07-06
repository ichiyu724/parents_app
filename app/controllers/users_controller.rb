class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def account
    @user = current_user
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
        render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:icon_image, :username, :profile).merge(id: current_user.id)
  end
end
