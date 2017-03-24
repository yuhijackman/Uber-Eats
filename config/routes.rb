Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :restaurants, only: [:index]
  resources :users, only: [:show]
end
