# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminRoom::MemberRegistrationRequest', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:member_registration_request) { FactoryBot.create(:member_registration_request) }

  within_subdomain 'guillamap' do
    describe 'GET /admin_room/member_registration_requests' do
      let(:action) { get '/admin_room/member_registration_requests' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the member registration requests page' do
          expect(response.body).to match('Nouvelles inscriptions')
        end
      end
    end

    describe 'GET /admin_room/member_registration_requests/1' do
      let(:action) { get "/admin_room/member_registration_requests/#{member_registration_request.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the member registration request page' do
          expect(response.body).to match(member_registration_request.email)
        end
      end
    end
  end
end
