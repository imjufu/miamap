# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MembershipsController, type: :routing do
  describe 'routing' do
    it 'does not route to #index' do
      expect(get: '/members/1/memberships').not_to route_to(
        'memberships#index'
      )
    end

    it 'routes to #new' do
      expect(get: '/members/1/memberships/new').to route_to(
        'memberships#new', member_id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: '/members/1/memberships/1').to route_to(
        'memberships#show', id: '1', member_id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: '/members/1/memberships/1/edit').to route_to(
        'memberships#edit', id: '1', member_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/members/1/memberships').to route_to(
        'memberships#create', member_id: '1'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/members/1/memberships/1').to route_to(
        'memberships#update', id: '1', member_id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/members/1/memberships/1').to route_to(
        'memberships#update', id: '1', member_id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/members/1/memberships/1').to route_to(
        'memberships#destroy', id: '1', member_id: '1'
      )
    end
  end
end
