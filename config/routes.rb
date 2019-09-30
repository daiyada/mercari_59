Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :users, only: [:index, :edit] do
    member do
      get "logout" => "users#logout"
      get "info"  => "users#info"
    end
  end
  resources :cards, only: [:show]
  resources :items, only: [:show, :new , :index] do
    collection do
      get "purchase/:id" => "items#purchase"
    end
  end
end
