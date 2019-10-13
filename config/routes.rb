Rails.application.routes.draw do

  resources :signup do
    collection do
      get "step1"
      get "step2"
      get "step3"
      get "step4"
      get "done"
    end
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  root "items#index"
  resources :users, only: [:index, :edit, :new] do
    member do
      get "logout" => "users#logout"
      get "info"  => "users#info"
    end
  end

  resources :cards, only: [:show, :create, :edit, :new, :destroy]
  resources :items, only: [:show, :new , :index, :create, :destroy] do
    member do
      post "pay"  =>  "items#pay"
    end
    collection do
      get "purchase/:id" => "items#purchase"
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end
