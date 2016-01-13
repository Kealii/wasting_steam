class ResultsController < ApplicationController
  def index
    @results = ['nada']
    @total = @results.count
  end
end
