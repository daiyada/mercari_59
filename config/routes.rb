Rails.application.routes.draw do
  devise_for :users
  root "example#index"
  resources :users, only: [:index, :edit]
  resources :items, only: [:show, :new] do
    collection do
      get "purchase/:id" => "items#purchase"
    end
  end
end
