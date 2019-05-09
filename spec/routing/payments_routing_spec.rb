# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentsController, type: :routing do
  describe 'routing' do
    it 'does not route to #index' do
      expect(get: '/subscriptions/1/payments').not_to route_to(
        'payments#index', subscription_id: '1'
      )
    end

    it 'routes to #new' do
      expect(get: '/subscriptions/1/payments/new').to route_to(
        'payments#new', subscription_id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: '/subscriptions/1/payments/1').to route_to(
        'payments#show', id: '1', subscription_id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: '/subscriptions/1/payments/1/edit').to route_to(
        'payments#edit', id: '1', subscription_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/subscriptions/1/payments').to route_to(
        'payments#create', subscription_id: '1'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/subscriptions/1/payments/1').to route_to(
        'payments#update', id: '1', subscription_id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/subscriptions/1/payments/1').to route_to(
        'payments#update', id: '1', subscription_id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/subscriptions/1/payments/1').to route_to(
        'payments#destroy', id: '1', subscription_id: '1'
      )
    end
  end
end
