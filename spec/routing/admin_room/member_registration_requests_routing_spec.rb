# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminRoom::MemberRegistrationRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin_room/member_registration_requests').to route_to(
        'admin_room/member_registration_requests#index'
      )
    end

    it 'routes to #show' do
      expect(get: '/admin_room/member_registration_requests/1').to route_to(
        'admin_room/member_registration_requests#show', id: '1'
      )
    end
  end
end
