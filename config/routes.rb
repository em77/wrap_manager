Rails.application.routes.draw do
  
  # For LetsEncrypt verification with sabayon
  if ENV['ACME_KEY'] && ENV['ACME_TOKEN']
    get ".well-known/acme-challenge/#{ ENV["ACME_TOKEN"] }" =>
      proc { [200, {}, [ ENV["ACME_KEY"] ] ] }
  end
  
  # Handle multiple ACME tokens more efficiently
  # Only process this at load time, not on each request
  if ENV.keys.grep(/^ACME_TOKEN_/).any?
    ENV.keys.grep(/^ACME_TOKEN_/).each do |var|
      number = var.sub(/ACME_TOKEN_/, '')
      if ENV["ACME_KEY_#{number}"]
        token = ENV["ACME_TOKEN_#{number}"]
        key = ENV["ACME_KEY_#{number}"]
        get ".well-known/acme-challenge/#{token}" => proc { [200, {}, [key]] } if token && key
      end
    end
  end

  resources :users
  resources :user_sessions
  resources :password_resets
  resources :clients
  resources :appointments
  resources :client_actions
  resources :monthly_stats, only: [:index]

  get "login" => "user_sessions#new", as: :login
  get "logout" => "user_sessions#destroy", as: :logout

  get "/add_user_to_client" => "clients#add_user_to_client",
    as: "add_user_to_client"

  get "/remove_user_from_client" => "clients#remove_user_from_client",
    as: "remove_user_from_client"

  get "/users/:id/my_calendar" => "users#my_calendar", as: :my_calendar

  get "unassigned" => "clients#unassigned", as: :unassigned

  get "/users/:id/my_clients" => "users#my_clients", as: :my_clients

  root to: "pages#home"
end
