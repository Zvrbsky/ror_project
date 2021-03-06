# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_for :hosts
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'

  get '/featured', to: 'events#featured'
  get '/search', to: 'events#search'

  resources :events do
    member do
      get 'add_to_cart'
      get 'back'
    end
  end

  resources :carts, only: [:index] do
    collection do
      post :confirm
    end
  end

  namespace :host_panel, path: 'host_panel' do
    root to: 'profile#index'
  end

  namespace :user_panel, path: 'user_panel' do
    root to: 'profile#index'

    resources :orders, only: %i[show index] do
      member do
        post 'confirm'
      end
    end
  end

  namespace :host do
    resources :events
  end

  namespace :api do
    get 'users/email_exists', to: 'users#email_exists'
    get 'hosts/email_exists', to: 'hosts#email_exists'

    resources :events, only: [:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
