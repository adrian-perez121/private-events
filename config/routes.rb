Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resources :events, only: [:new, :create, :edit, :update, :destroy] do
      resources :events_details, only: [:destroy]
      resources :invites, only: [:create]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "events#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :events, only: [:index, :show] do
    resources :events_details, only: [:create]
  end

  # Defines the root path route ("/")
  # root "posts#index"

end
