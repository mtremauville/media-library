Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
      sessions: "users/sessions",
      registrations: "users/registrations"
    }

  root "home#index"

  # API routes
  namespace :api do
    namespace :v1 do
      resources :media_items, only: [:index, :show, :create, :update, :destroy]
      resources :search, only: [:index]
      get "movies/:id",  to: "movies#show"
      get "series/:id",  to: "series#show"
      get "albums/:id",  to: "albums#show"
    end
  end
end
