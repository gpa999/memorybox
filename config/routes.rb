Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "top#index"
  resources :posts, except: :index
  resources :users do 
    resources :posts, only: :index
  end
end
