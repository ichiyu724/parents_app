class HistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vaccination, only: %i[new edit create update]
  before_action :set_child, only: %i[new edit create update index]
  before_action :set_history, only: %i[edit update]
  

  def new
    if params[:vaccination_id]
      @vaccination = Vaccination.find(params[:vaccination_id])
      @history = @child.histories.new
      @history.vaccination_id = @vaccination.id
      session[:previous_url] = request.referer
    end
  end

  def index
    @vaccinations = Vaccination.all.order(:id)
    @histories = @child.histories
  end

  def create
    @history = @child.histories.new(history_params)
    if @history.save
      flash[:notice] = '接種予定日を登録しました。'
      redirect_to user_child_histories_path
    else 
      flash.now[:alert] = '登録に失敗しました。'
      render("history/new")
    end 
  end

  def edit
    if params[:vaccination_id]
      @vaccination = Vaccination.find(params[:vaccination_id])
      @history.vaccination_id = @vaccination.id
      session[:previous_url] = request.referer
    end
  end

  def update
    if @history.update(history_params)
      flash[:notice] = '接種日を記録しました。'
      redirect_to user_child_histories_path
    else 
      flash.now[:alert] = '登録に失敗しました。'
      render("history/edit")
    end
  end

  private

  def history_params
    params.require(:history).permit(:date, :vaccinated, :vaccination_id).merge(child_id: @child.id)
  end

  def set_vaccination
    @vaccination = History.where(vaccination_id: params[:id])
  end

  def set_child
    @child = current_user.children.find(params[:child_id])
  end

  def set_history
    @history = @child.histories.find(params[:id])
  end
end
