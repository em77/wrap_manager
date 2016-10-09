Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :user_sessions
  resources :password_resets
  resources :clients
  resources :appointments

  get "login" => "user_sessions#new", as: :login
  get "logout" => "user_sessions#destroy", as: :logout

  get "/add_user_to_client" => "users#add_user_to_client",
    as: "add_user_to_client"

  root to: "pages#home"
end
