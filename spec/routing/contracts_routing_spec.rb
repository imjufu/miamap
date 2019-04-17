# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContractsController, type: :routing do
  describe 'routing' do
    it 'does not route to #index' do
      expect(get: '/farmers/1/contracts').not_to route_to(
        'contracts#index', farmer_id: '1'
      )
    end

    it 'routes to #new' do
      expect(get: '/farmers/1/contracts/new').to route_to(
        'contracts#new', farmer_id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: '/farmers/1/contracts/1').to route_to(
        'contracts#show', id: '1', farmer_id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: '/farmers/1/contracts/1/edit').to route_to(
        'contracts#edit', id: '1', farmer_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/farmers/1/contracts').to route_to(
        'contracts#create', farmer_id: '1'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/farmers/1/contracts/1').to route_to(
        'contracts#update', id: '1', farmer_id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/farmers/1/contracts/1').to route_to(
        'contracts#update', id: '1', farmer_id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/farmers/1/contracts/1').to route_to(
        'contracts#destroy', id: '1', farmer_id: '1'
      )
    end
  end
end
