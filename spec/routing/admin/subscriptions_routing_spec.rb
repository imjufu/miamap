# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::SubscriptionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/subscriptions').to route_to(
        'admin/subscriptions#index'
      )
    end

    it 'routes to #new' do
      expect(get: '/admin/subscriptions/new').to route_to(
        'admin/subscriptions#new'
      )
    end

    it 'routes to #show' do
      expect(get: '/admin/subscriptions/1').to route_to(
        'admin/subscriptions#show', id: '1'
      )
    end

    it 'routes to #preview' do
      expect(get: '/admin/subscriptions/1/preview').to route_to(
        'admin/subscriptions#preview', id: '1'
      )
    end

    it 'does not route to #edit' do
      expect(get: '/admin/subscriptions/1/edit').not_to route_to(
        'admin/subscriptions#edit', id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/admin/subscriptions').to route_to(
        'admin/subscriptions#create'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/subscriptions/1').to route_to(
        'admin/subscriptions#update', id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/subscriptions/1').to route_to(
        'admin/subscriptions#update', id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/subscriptions/1').to route_to(
        'admin/subscriptions#destroy', id: '1'
      )
    end
  end
end
