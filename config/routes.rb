Rails.application.routes.draw do
  root to: "home#index"
  match "/about", to: "home#about", via: :get

  resources :surveys, path: :s, only: [:show, :new, :create] do
    member do
      # Yes, it would probably be more correct to put this in its
      # own controller under the surveys scope - I'm taking this
      # direction for simplicity, and keeping the whole flow clear.
      scope :actions do
        post :answer
      end
    end
  end
end
