# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminRoom::WelcomeController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin_room').to route_to('admin_room/welcome#index')
    end
  end
end
