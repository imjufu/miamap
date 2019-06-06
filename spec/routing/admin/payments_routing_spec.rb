# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::PaymentsController, type: :routing do
  describe 'routing' do
    it 'does not route to #index' do
      expect(get: '/admin/subscriptions/1/payments').not_to route_to(
        'admin/payments#index', subscription_id: '1'
      )
    end

    it 'routes to #new' do
      expect(get: '/admin/subscriptions/1/payments/new').to route_to(
        'admin/payments#new', subscription_id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: '/admin/subscriptions/1/payments/1').to route_to(
        'admin/payments#show', id: '1', subscription_id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: '/admin/subscriptions/1/payments/1/edit').to route_to(
        'admin/payments#edit', id: '1', subscription_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/admin/subscriptions/1/payments').to route_to(
        'admin/payments#create', subscription_id: '1'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/subscriptions/1/payments/1').to route_to(
        'admin/payments#update', id: '1', subscription_id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/subscriptions/1/payments/1').to route_to(
        'admin/payments#update', id: '1', subscription_id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/subscriptions/1/payments/1').to route_to(
        'admin/payments#destroy', id: '1', subscription_id: '1'
      )
    end
  end
end
