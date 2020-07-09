Rails.application.routes.draw do
  resources :bookmarks
  post "/login", to: "user_token#create"
  post "/sign-up", to: "users#create"
  put "/users", to: "users#update"
  get "/status", to: "status#index"
  get "/status/user", to: "status#user"
end
