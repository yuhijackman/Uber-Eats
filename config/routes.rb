Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :restaurants, only: [:index, :show]
  resources :users, only: [:show]

  resources :menus, only: [:search]do
    collection do
      get 'search'
    end
  end
end
