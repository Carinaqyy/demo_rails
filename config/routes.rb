Rails.application.routes.draw do
  # resources :users
  # resources :microposts do
  #   resources :comments
  # end
  resources :users do
    resources :microposts do
      resources :comments
    end
  end
  resources :users
  resources :microposts
  resources :comments
  root "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "posts#index"
end
