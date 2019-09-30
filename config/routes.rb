Rails.application.routes.draw do
  devise_for :users
  root "example#index"
  resources :users, only: [:index, :edit] do
    member do
      get "logout" => "users#logout"
    end
  end
  resources :cards, only: [:show]
  resources :items, only: [:show, :new , :index] do
    collection do
      get "purchase/:id" => "items#purchase"
    end
  end
end
