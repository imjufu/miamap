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
          expect(response.body).to match("Demandes d'inscription")
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

    describe 'PUT /admin_room/member_registration_requests/1/accept' do
      let(:action) { put "/admin_room/member_registration_requests/#{member_registration_request.id}/accept" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'redirects to the member registration request page' do
          action
          expect(response).to redirect_to(
            admin_room_member_registration_request_path(
              id: member_registration_request.id
            )
          )
        end

        it 'updates the member registration request' do
          expect do
            action
            member_registration_request.reload
          end.to change(member_registration_request, :accepted_at).from(nil).to(Time)
        end
      end
    end

    describe 'PUT /admin_room/member_registration_requests/1/refuse' do
      let(:action) { put "/admin_room/member_registration_requests/#{member_registration_request.id}/refuse" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'redirects to the member registration request page' do
          action
          expect(response).to redirect_to(
            admin_room_member_registration_request_path(
              id: member_registration_request.id
            )
          )
        end

        it 'updates the member registration request' do
          expect do
            action
            member_registration_request.reload
          end.to change(member_registration_request, :refused_at).from(nil).to(Time)
        end
      end
    end
  end
end
