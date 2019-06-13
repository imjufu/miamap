# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemberRoom::WelcomeController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/member_room').to route_to('member_room/welcome#index')
    end
  end
end
