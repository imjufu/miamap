# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProducersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/producers').to route_to('admin/producers#index')
    end

    it 'routes to #new' do
      expect(get: '/admin/producers/new').to route_to('admin/producers#new')
    end

    it 'routes to #show' do
      expect(get: '/admin/producers/1').to route_to('admin/producers#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/producers/1/edit').to route_to('admin/producers#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/producers').to route_to('admin/producers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/producers/1').to route_to('admin/producers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/producers/1').to route_to('admin/producers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/producers/1').to route_to('admin/producers#destroy', id: '1')
    end
  end
end
