Rails.application.routes.draw do
  devise_for :users
  root "example#index"
  resources :users, only: [:index, :edit]
  resources :items, only: [:show]
end
