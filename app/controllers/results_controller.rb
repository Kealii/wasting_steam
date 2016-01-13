class ResultsController < ApplicationController
  def index
    if current_user
      url = URI.parse("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_API_KEY']}&steamid=#{current_user.uid}&format=json")
      response = Net::HTTP::get(url)
      @results = JSON.load(response)['response']['games']
    end
  end
end
