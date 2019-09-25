Rails.application.routes.draw do
  devise_for :users
  devise_for :items
  root "items#new"
end
