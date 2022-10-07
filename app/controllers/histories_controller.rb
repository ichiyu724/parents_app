class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def new
    if params[:vaccination_id]
      @vaccination = Vaccination.find(params[:vaccination_id])
      @child = current_user.children.find(params[:child_id])      
      @history = @child.histories.new
      @history.vaccination_id = @vaccination.id
      session[:previous_url] = request.referer
    end
  end

  def index
    @vaccinations = Vaccination.all.order(:id)
    @child = current_user.children.find(params[:child_id])
    @histories = @child.histories
  end

  def create
    @child = current_user.children.find(params[:child_id])
    @history = @child.histories.new(history_params)
    #@vaccination = Vaccination.find(params[:vaccination_id])
    #@history.vaccination_id = @vaccination.id
    if @history.save
      @history.vaccinated == true
      flash[:notice] = '接種予定日を登録しました。'
      redirect_to user_child_histories_path
    else 
      flash.now[:alert] = '登録に失敗しました。'
      render ("history/new")
    end 
  end

  def edit
    if params[:vaccination_id]
      @vaccination = Vaccination.find(params[:vaccination_id])
      @child = current_user.children.find(params[:child_id])      
      @history = @vaccination.histories.find(params[:id])
      @history.vaccination_id = @vaccination.id
      session[:previous_url] = request.referer
    end
  end

  def update
    @child = current_user.children.find(params[:child_id])
    @history = @child.histories.find(params[:id])
    #@vaccination = Vaccination.find(params[:vaccination_id])
    #@history.vaccination_id = @vaccination.id
    if @history.update(history_params)
      @history.vaccinated == true
      flash[:notice] = '接種日を記録しました。'
      redirect_to user_child_histories_path
    else 
      flash.now[:alert] = '登録に失敗しました。'
      render ("history/edit")
    end
  end

  def show

  end

  private

  def history_params
    params.require(:history).permit(:date, :vaccinated, :vaccination_id)
  end
end
