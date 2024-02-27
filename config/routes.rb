Rails.application.routes.draw do
  root to:'top_page#index'
  get 'home/index'

  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:new, :create, :destroy]
  resource :profile, only: %i[show edit update]
  resources :spots do
    resources :feedbacks, only: %i[create destroy edit update], shallow: true
    resources :likes, only: [:create, :destroy]
  end
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'user_sessions#new'
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get "guest_login", to: "users#guest_login"
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
