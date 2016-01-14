require 'rails_helper'

feature 'testing oauth' do

  before :each do
    OmniAuth.config.mock_auth[:steam] = nil
    stub_omniauth
  end

  scenario 'login with steam' do
    visit login_path

    expect(current_path).to eq(waste_analysis_path)
    expect(page).to have_content('Hello Testing Steam')
    expect(page).to have_content('Click Here To Analyze')
    expect(page).to have_content('Logout')
  end

  scenario 'logout with steam' do
    visit login_path
    visit logout_path

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content('Hello Testing Steam')
    expect(page).to_not have_content('Logout')
    expect(page).to     have_content('Login')
  end

  scenario 'login with bad steam credentials' do
    login_with_bad_credentials
    visit login_path

    expect(current_path).to eq(root_path)
    # expect(current_path).to have_content("Invalid Credentials. Please Try Again.")
  end

end