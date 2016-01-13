Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/steam', as: :login
  post '/auth/steam/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout
end
