# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :members do
      resources :memberships, except: %i[index]
    end
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

  namespace :member_room do
    root to: 'welcome#index'
  end

  devise_for :users, path: 'admin'
  devise_for :members, path: 'member_room'

  root to: 'welcome#index'
end
