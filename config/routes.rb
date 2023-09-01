Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
  
  devise_for :users
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources  :likes, only: [:create]
      get 'likes', to: 'likes#like', on: :member
   end
  end
end
