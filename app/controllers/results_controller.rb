class ResultsController < ApplicationController
  def index
    if current_user
      url = URI.parse("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_API_KEY']}&steamid=#{current_user.uid}&format=json")
      response = Net::HTTP::get(url)
      @results = JSON.load(response)['response']['games']
      @unplayed_ids = []
      @results.each do |results|
        if results['playtime_forever'] <= 5
          @unplayed_ids << results['appid']
        end
      end
      @total = @unplayed_ids.count
    end
  end
end
