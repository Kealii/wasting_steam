require 'rails_helper'

feature 'testing oauth' do

  before :each do
    OmniAuth.config.mock_auth[:steam] = nil
  end

  scenario 'login with steam' do
    stub_omniauth
    visit login_path

    expect(current_path).to eq(waste_analysis_path)
  end

end