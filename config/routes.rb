Rails.application.routes.draw do
  devise_for :users
  root "example#index"
  resources :users, only: [:index]
  resources :items, only: [:show]
<<<<<<< HEAD
end
end
=======
end
>>>>>>> master
