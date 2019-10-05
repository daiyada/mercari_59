Rails.application.routes.draw do
  devise_for :users

  root "items#index"
  resources :users, only: [:index, :edit, :new] do
    member do
      get "logout" => "users#logout"
      get "info"  => "users#info"
    end
  end
  
  resources :cards, only: [:show, :edit]
  resources :items, only: [:show, :new , :index, :create] do
    
    collection do
      get "purchase/:id" => "items#purchase"
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end
