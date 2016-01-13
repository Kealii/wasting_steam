Rails.application.routes.draw do

  root 'welcome#index'

  get 'waste_analysis', to: 'waste_analysis#index'
  get 'results',        to: 'waste_analysis#results'
  get '/auth/steam',    as: :login
  post '/auth/steam/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
