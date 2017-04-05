Rails.application.routes.draw do

  devise_for :users
  root 'top#index'

  resources :restaurants, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  resources :users, only: [:show]

  resources :menus, only: [:search]do
    collection do
      get 'search'
    end
  end

  resources :orders, only: [:create, :show]

end
