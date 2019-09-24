Rails.application.routes.draw do
  devise_for :users
  root "example#index"
  resources :items, only: [:show]
end