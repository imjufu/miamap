# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin_room do
    resources :users
    resources :member_registration_requests, only: %i[index show] do
      put :accept, on: :member
      put :refuse, on: :member
    end
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
    resources :subscriptions, only: %i[index show]
  end

  devise_for :users, path: 'admin_room'
  devise_for :members, path: 'member_room'

  delete :members_sign_up, to: 'members_sign_up#destroy'
  scope :members_sign_up, as: :members_sign_up do
    get :step_1, to: 'members_sign_up#step_1'
    post :step_1, to: 'members_sign_up#save_step_1'
    get :step_2, to: 'members_sign_up#step_2'
    patch :step_2, to: 'members_sign_up#save_step_2'
    get :step_3, to: 'members_sign_up#step_3'
    patch :step_3, to: 'members_sign_up#save_step_3'
    get :step_4, to: 'members_sign_up#step_4'
  end

  root to: 'welcome#index'
end
