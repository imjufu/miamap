# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ContractsController, type: :routing do
  describe 'routing' do
    it 'does not route to #index' do
      expect(get: '/admin/producers/1/contracts').not_to route_to(
        'admin/contracts#index', producer_id: '1'
      )
    end

    it 'routes to #new' do
      expect(get: '/admin/producers/1/contracts/new').to route_to(
        'admin/contracts#new', producer_id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: '/admin/producers/1/contracts/1').to route_to(
        'admin/contracts#show', id: '1', producer_id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: '/admin/producers/1/contracts/1/edit').to route_to(
        'admin/contracts#edit', id: '1', producer_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/admin/producers/1/contracts').to route_to(
        'admin/contracts#create', producer_id: '1'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/producers/1/contracts/1').to route_to(
        'admin/contracts#update', id: '1', producer_id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/producers/1/contracts/1').to route_to(
        'admin/contracts#update', id: '1', producer_id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/producers/1/contracts/1').to route_to(
        'admin/contracts#destroy', id: '1', producer_id: '1'
      )
    end
  end
end
