# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MembershipFormsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/membership_forms').to route_to('membership_forms#index')
    end

    it 'routes to #new' do
      expect(get: '/membership_forms/new').to route_to('membership_forms#new')
    end

    it 'routes to #show' do
      expect(get: '/membership_forms/1').to route_to(
        'membership_forms#show', id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: '/membership_forms/1/edit').to route_to(
        'membership_forms#edit', id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/membership_forms').to route_to('membership_forms#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/membership_forms/1').to route_to(
        'membership_forms#update', id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/membership_forms/1').to route_to(
        'membership_forms#update', id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/membership_forms/1').to route_to(
        'membership_forms#destroy', id: '1'
      )
    end
  end
end
