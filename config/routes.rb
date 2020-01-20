Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "top#index"
  resources :posts, except: :index do 
    member do
      get :destroy_confirm
    end

    resources :comments, only: [:create]
  end
  resources :users do 
    resources :posts, only: :index
    collection do
      get :followed_posts
    end

    member do
      get :follower_index
      get :following_index
    end
  end

  resources :relationships, only: [:create, :destroy]

end
