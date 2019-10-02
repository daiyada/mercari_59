Rails.application.routes.draw do
  devise_for :users
  root "example#index"
  resources :users, only: [:index, :edit]
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
