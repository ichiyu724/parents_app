class HistoriesController < ApplicationController
  def new
    @history = History.new
    #@history.vaccination_id = @vaccination.id
  end
end
