# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::MembersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/members').to route_to('admin/members#index')
    end

    it 'routes to #new' do
      expect(get: '/admin/members/new').to route_to('admin/members#new')
    end

    it 'routes to #show' do
      expect(get: '/admin/members/1').to route_to('admin/members#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/members/1/edit').to route_to('admin/members#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/members').to route_to('admin/members#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/members/1').to route_to('admin/members#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/members/1').to route_to('admin/members#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/members/1').to route_to('admin/members#destroy', id: '1')
    end
  end
end
