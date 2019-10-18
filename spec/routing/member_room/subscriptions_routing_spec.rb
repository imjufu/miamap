# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemberRoom::SubscriptionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/member_room/subscriptions').to route_to(
        'member_room/subscriptions#index'
      )
    end

    it 'routes to #show' do
      expect(get: '/member_room/subscriptions/1').to route_to(
        'member_room/subscriptions#show', id: '1'
      )
    end
  end
end
