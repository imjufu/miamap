# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::MembershipsController, type: :routing do
  describe 'routing' do
    it 'does not route to #index' do
      expect(get: '/admin/members/1/memberships').not_to route_to(
        'admin/memberships#index'
      )
    end

    it 'routes to #new' do
      expect(get: '/admin/members/1/memberships/new').to route_to(
        'admin/memberships#new', member_id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: '/admin/members/1/memberships/1').to route_to(
        'admin/memberships#show', id: '1', member_id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: '/admin/members/1/memberships/1/edit').to route_to(
        'admin/memberships#edit', id: '1', member_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/admin/members/1/memberships').to route_to(
        'admin/memberships#create', member_id: '1'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/members/1/memberships/1').to route_to(
        'admin/memberships#update', id: '1', member_id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/members/1/memberships/1').to route_to(
        'admin/memberships#update', id: '1', member_id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/members/1/memberships/1').to route_to(
        'admin/memberships#destroy', id: '1', member_id: '1'
      )
    end
  end
end
