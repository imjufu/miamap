# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::WelcomeController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin').to route_to('admin/welcome#index')
    end
  end
end
