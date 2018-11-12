# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :hosts
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'

  resources :events do
    member do
      get 'buy'
    end
  end

  namespace :host_panel, path: 'host_panel' do
    root to: 'profile#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
