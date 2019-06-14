# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminRoom::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin_room/users').to route_to('admin_room/users#index')
    end

    it 'routes to #new' do
      expect(get: '/admin_room/users/new').to route_to('admin_room/users#new')
    end

    it 'routes to #show' do
      expect(get: '/admin_room/users/1').to route_to('admin_room/users#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin_room/users/1/edit').to route_to('admin_room/users#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin_room/users').to route_to('admin_room/users#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin_room/users/1').to route_to('admin_room/users#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin_room/users/1').to route_to('admin_room/users#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin_room/users/1').to route_to('admin_room/users#destroy', id: '1')
    end
  end
end
