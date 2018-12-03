# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_for :host
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'

  get '/featured', to: 'events#featured'
  get '/search', to: 'events#search'

  resources :events do
    member do
      get 'buy'
      get 'back'
    end
  end

  resources :carts, only: [:index]

  namespace :host_panel, path: 'host_panel' do
    root to: 'profile#index'
  end

  namespace :user_panel, path: 'user_panel' do
    root to: 'profile#index'
  end

  namespace :host do
    resources :events
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
