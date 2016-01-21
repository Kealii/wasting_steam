class ResultsController < ApplicationController
  def index
    find_games if current_user
  end

  def find_games
    @unplayed_ids = []
    url      = URI.parse("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_API_KEY']}&steamid=#{current_user.uid}&format=json")
    response = Net::HTTP::get(url)
    games    = JSON.load(response)['response']['games']
    if games
      games.each do |game|
        @unplayed_ids << game['appid'] if game['playtime_forever'] < 5
      end
    end
  end

  def price
    id = params[:id]
    find_price(id)

    render json: {
               id: id,
               name: @name,
               cost: @cost/100.0,
               image: @image,
               genre: @genre,
               score: @score,
               critic: @critic
           }
  end

  def find_price(id)
    url      = URI.parse("https://store.steampowered.com/api/appdetails/?appids=#{id}")
    response = Net::HTTP::get(url)
    game = JSON.load(response)["#{id}"]
    if game['data']
      if game['data']['name']
        @name = game['data']['name']
      end
      if game['data']['price_overview']
        @cost = game['data']['price_overview']['initial']
      end
      if game['data']['header_image']
        @image =  game['data']['header_image']
      end
      if game['data']['genres']
        @genre =  game['data']['genres'].first['description']
      end
      if game['data']['metacritic']
        @score =  game['data']['metacritic']['score']
        @critic = game['data']['metacritic']['url']
      end
    end
  end
end

