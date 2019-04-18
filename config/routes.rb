# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :members
  resources :subscriptions, except: %i[edit]
  resources :producers do
    resources :contracts, except: %i[index]
  end
  root to: 'welcome#index'
end
