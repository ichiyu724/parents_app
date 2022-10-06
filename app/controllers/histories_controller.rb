class HistoriesController < ApplicationController
  def new
    @child = current_user.children.find(params[:child_id])
    @vaccination = Vaccination.find(params[:vaccination_id])
    @history = @child.history.new
    @history.vaccination_id = @vaccination.id
    session[:previous_url] = request.referer
  end

  def index
    @vaccinations = Vaccination.all.order(:id)
    @child = current_user.children.find(params[:child_id])
    @histories = @child.history
  end
end
