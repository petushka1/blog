Rails.application.routes.draw do
  devise_for :users
  
  root 'users#index'
  resources :users, only: :show do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create]
      resources :likes, only: :create
    end
  end
end
