Rails.application.routes.draw do
  resources :bookmarks
  post "/login", to: "user_token#create"
  post "/sign-up", to: "users#create"
  get "/status", to: "status#index"
  # => http://localhost:3000/status
  get "/status/user", to: "status#user"
end
