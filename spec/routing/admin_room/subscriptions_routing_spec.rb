# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminRoom::SubscriptionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin_room/subscriptions').to route_to(
        'admin_room/subscriptions#index'
      )
    end

    it 'routes to #new' do
      expect(get: '/admin_room/subscriptions/new').to route_to(
        'admin_room/subscriptions#new'
      )
    end

    it 'routes to #show' do
      expect(get: '/admin_room/subscriptions/1').to route_to(
        'admin_room/subscriptions#show', id: '1'
      )
    end

    it 'routes to #preview' do
      expect(get: '/admin_room/subscriptions/1/preview').to route_to(
        'admin_room/subscriptions#preview', id: '1'
      )
    end

    it 'does not route to #edit' do
      expect(get: '/admin_room/subscriptions/1/edit').not_to route_to(
        'admin_room/subscriptions#edit', id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/admin_room/subscriptions').to route_to(
        'admin_room/subscriptions#create'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin_room/subscriptions/1').to route_to(
        'admin_room/subscriptions#update', id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin_room/subscriptions/1').to route_to(
        'admin_room/subscriptions#update', id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/admin_room/subscriptions/1').to route_to(
        'admin_room/subscriptions#destroy', id: '1'
      )
    end
  end
end
