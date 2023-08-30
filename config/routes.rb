Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources  :likes, only: [:create]
      get 'likes', to: 'likes#like', on: :member
   end
  end
end
