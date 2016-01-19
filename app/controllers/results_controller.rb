class ResultsController < ApplicationController
  def index
    if current_user
      find_games
      find_prices
    end
  end


  def find_games
    @unplayed_ids = []
    url      = URI.parse("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_API_KEY']}&steamid=#{current_user.uid}&format=json")
    response = Net::HTTP::get(url)
    games    = JSON.load(response)['response']['games']
    games.each do |game|
      if game['playtime_forever'] < 5
        @unplayed_ids << game['appid']
      end
    end
  end

  def find_prices
    @names        = []
    @images       = []
    @wasted_money = 0
    @unplayed_ids.each do |id|
      url      = URI.parse("https://store.steampowered.com/api/appdetails/?appids=#{id}")
      response = Net::HTTP::get(url)
      game = JSON.load(response)["#{id}"]
      if game['data']['name']
        @names << game['data']['name']
      end
      if game['data']['price_overview']
        @wasted_money += game['data']['price_overview']['initial']
      end
      if game['data']['header_image']
        @images << game['data']['header_image']
      end
    end
  end

end

