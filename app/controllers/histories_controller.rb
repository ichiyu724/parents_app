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
end
