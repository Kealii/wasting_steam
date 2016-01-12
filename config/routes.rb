Rails.application.routes.draw do
  root 'welcome#index'
  resources :login, only: [:index]
end
