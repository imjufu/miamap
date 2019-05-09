# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :members
  resources :membership_forms
  resources :subscriptions, except: %i[edit] do
    get :preview, on: :member
    resources :payments, except: %i[index]
  end
  resources :producers do
    resources :contracts, except: %i[index]
  end
  root to: 'welcome#index'
end
