# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminRoom::ProducersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin_room/producers').to route_to('admin_room/producers#index')
    end

    it 'routes to #new' do
      expect(get: '/admin_room/producers/new').to route_to('admin_room/producers#new')
    end

    it 'routes to #show' do
      expect(get: '/admin_room/producers/1').to route_to('admin_room/producers#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin_room/producers/1/edit').to route_to('admin_room/producers#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin_room/producers').to route_to('admin_room/producers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin_room/producers/1').to route_to('admin_room/producers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin_room/producers/1').to route_to('admin_room/producers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin_room/producers/1').to route_to('admin_room/producers#destroy', id: '1')
    end
  end
end
