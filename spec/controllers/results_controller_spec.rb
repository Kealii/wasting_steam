require 'rails_helper'

def sign_in(user)
  session[:user_id] = user.id
end

def sign_out
  session.delete(:user_id)
end

RSpec.describe ResultsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "finds the games for the user" do
      user = User.create!(uid: ENV['TEST_UID'])
      sign_in user
      get :index

      expect(assigns(:unplayed_ids)).to match_array([1500, 1510, 1520, 1530])
    end
  end

  describe "GET #price" do
    it 'returns the price of a game' do
      user = User.create!(uid: ENV['TEST_UID'])
      sign_in user
      get :price, id: '1500'
      price = JSON.parse(response.body)

      expect(price).to eq({
                         'id' => '1500',
                         'name' => 'Darwinia',
                         'cost' => 9.99,
                         'image' => 'https://steamcdn-a.akamaihd.net/steam/apps/1500/header.jpg?t=1447350833',
                         'genre' => 'Indie',
                         'score' => 84,
                         'critic' => 'http://www.metacritic.com/game/pc/darwinia'
                       })
    end
  end

end
