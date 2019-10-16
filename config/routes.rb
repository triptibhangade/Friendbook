Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  post "accept_request/:id" => "friendships#accept_request", as: :accept_request
  post "create_friend/:id" => "friendships#create", as: :create_friendship
  get "users/friendrequest/:id" => "users#friendrequest", as: :friendrequest
  get "users/sentrequest/:id" => "users#sentrequest", as: :sentrequest
  get "users/friends/:id" => "users#friends", as: :friends

  resources :friendships, only: [:create, :destroy]

  root :to => "sessions#new"

  resource :session, only: [:new,:create,:destroy]

  get "signin" => "sessions#new"
  get "signup" => "users#new"
  get "signout" => "sessions#new"

end
