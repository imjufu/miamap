# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :members
  resources :farmers
  root to: 'welcome#index'
end
