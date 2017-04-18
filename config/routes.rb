Rails.application.routes.draw do

  devise_for :users
  root 'top#index'

  resources :restaurants, only: [:index, :show] do
    collection do
      get 'search'
    end
    member do
      get 'location'
    end

  end

  resources :likes, only: [:create, :destroy]
  resources :dislikes, only: [:create]
  resources :caterings, only: [:create, :show]

  resources :users, only: [:show]

  resources :menus, only: [:search]do
    collection do
      get 'search'
    end
  end

  resources :orders, only: [:create, :show] do
    collection do
      get 'add'
      get 'cartList'
    end
  end

  resources :reviews, only: [:create]

end
