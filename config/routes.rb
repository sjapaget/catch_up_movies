Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :artists, only: :show
  resources :cinemas, only: :show

  resources :movies, only: %I[index show] do
    resources :comments, only: :create
    resources :interests, only: :create
  end

  resources :users do
    resources :interests, only: :index
    resources :bookings, only: :index
  end

  resources :movie_shows, only: [:index] do
    resources :bookings, only: :create
  end

  resources :interests, only: :destroy
  resources :follows, only: %I[index create destroy]

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end
end
