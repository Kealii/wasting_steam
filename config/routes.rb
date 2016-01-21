Rails.application.routes.draw do
  root 'welcome#index'
  get '/waste_analysis', to: 'waste_analysis#index'
  get '/results',       to: 'results#index'
  get '/auth/steam',    as: :login
  get  '/auth/steam/callback', to: 'sessions#create'
  post '/auth/steam/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/auth/failure',  to: 'sessions#failure'

  get '/results/:id', to: 'results#price'
end
