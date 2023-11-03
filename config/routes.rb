Rails.application.routes.draw do
  root "users#index"

  # resources :users do
  #   resources :microposts
  #   resources :comments
  # end
  resources :users do
    resources :microposts do
      resources :comments
    end
  end

  resources :users do
    resources :microposts, only: [:new, :create]
  end

  resources :microposts do
    resources :comments
  end
  resources :users
  resources :microposts
  resources :comments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "posts#index"
end
