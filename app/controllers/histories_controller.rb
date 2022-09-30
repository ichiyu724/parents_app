class HistoriesController < ApplicationController
  def new
    @history = History.new
  end
end
