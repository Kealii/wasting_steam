class WasteAnalysisController < ApplicationController
  def index
    @user = current_user
  end

  def results
    @results = ['nada']
    @total = @results.count
  end
end
