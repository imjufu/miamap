# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MembersSignUpController, type: :routing do
  describe 'routing' do
    it 'routes to #step_1' do
      expect(get: '/members_sign_up/step_1').to route_to('members_sign_up#step_1')
    end

    it 'routes to #save_step_1' do
      expect(post: '/members_sign_up/step_1').to route_to('members_sign_up#save_step_1')
    end

    it 'routes to #step_2' do
      expect(get: '/members_sign_up/step_2').to route_to('members_sign_up#step_2')
    end

    it 'routes to #save_step_2' do
      expect(patch: '/members_sign_up/step_2').to route_to('members_sign_up#save_step_2')
    end

    it 'routes to #step_3' do
      expect(get: '/members_sign_up/step_3').to route_to('members_sign_up#step_3')
    end

    it 'routes to #save_step_3' do
      expect(patch: '/members_sign_up/step_3').to route_to('members_sign_up#save_step_3')
    end

    it 'routes to #step_4' do
      expect(get: '/members_sign_up/step_4').to route_to('members_sign_up#step_4')
    end

    it 'routes to #destroy' do
      expect(delete: '/members_sign_up').to route_to('members_sign_up#destroy')
    end
  end
end
