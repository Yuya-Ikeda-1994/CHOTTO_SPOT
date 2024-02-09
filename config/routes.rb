Rails.application.routes.draw do
  root to:'top_page#index'
  get 'home/index'

  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:new, :create, :destroy]
  resource :profile, only: %i[show edit update]
  resources :spots, only: %i[index new create]

  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'user_sessions#new'
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
