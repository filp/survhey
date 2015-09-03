Rails.application.routes.draw do
  root to: "surveys#new"
  match "/about", to: "pages#about", via: :get

  # Account linking:
  match "/link/:uid", to: "accounts#set_uid", via: :get, as: :link_account

  # Front survey actions:
  match "/s/:id", to: "surveys#show", via: :get, as: :survey
  match "/new", to: redirect("/"), via: :get, as: :new_survey

  # "Backstage" survey actions:
  resources :surveys, only: [:destroy], as: :destroy_survey
  resources :surveys, only: [:index, :create] do
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
