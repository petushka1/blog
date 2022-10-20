Rails.application.routes.draw do
  devise_for :users, path: '/', path_names: {
    sign_in: 'login'
  }
  
  root 'users#index'
  resources :users, only: :show do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: :create
    end
  end
end
