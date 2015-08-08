Rails.application.routes.draw do
  root to: "home#index"

  resources :surveys, path: :s, only: [:show]
end
