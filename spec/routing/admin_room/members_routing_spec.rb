# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminRoom::MembersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin_room/members').to route_to('admin_room/members#index')
    end

    it 'routes to #new' do
      expect(get: '/admin_room/members/new').to route_to('admin_room/members#new')
    end

    it 'routes to #show' do
      expect(get: '/admin_room/members/1').to route_to('admin_room/members#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin_room/members/1/edit').to route_to('admin_room/members#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin_room/members').to route_to('admin_room/members#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin_room/members/1').to route_to('admin_room/members#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin_room/members/1').to route_to('admin_room/members#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin_room/members/1').to route_to('admin_room/members#destroy', id: '1')
    end
  end
end
