class ResultsController < ApplicationController
  def index
    if current_user
      @unplayed_ids = []
      @names        = []
      @wasted_money = 0
      url = URI.parse("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_API_KEY']}&steamid=#{current_user.uid}&format=json")
      response = Net::HTTP::get(url)
      @results = JSON.load(response)['response']['games']
      @results.each do |results|
        if results['playtime_forever'] < 5
          @unplayed_ids << results['appid']
        end
      end
      @unplayed_ids.each do |id|
        url      = URI.parse("https://store.steampowered.com/api/appdetails/?appids=#{id}")
        response = Net::HTTP::get(url)
        @game = JSON.load(response)["#{id}"]
        if @game['data']
          @names << @game['data']['name']
          if @game['data']['price_overview']
            @wasted_money += @game['data']['price_overview']['initial']
          end
        end
      end
    end
  end
end

