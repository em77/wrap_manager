Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :user_sessions
  resources :password_resets
  resources :clients
  resources :appointments
  resources :client_actions

  get "login" => "user_sessions#new", as: :login
  get "logout" => "user_sessions#destroy", as: :logout

  get "/add_user_to_client" => "clients#add_user_to_client",
    as: "add_user_to_client"

  get "/remove_user_from_client" => "clients#remove_user_from_client",
    as: "remove_user_from_client"

  get "/users/:id/my_calendar" => "users#my_calendar"

  get "/users/:id/user_cp" => "users#user_cp"

  get "/users/:id/my_clients" => "users#my_clients"

  root to: "pages#home"
end
