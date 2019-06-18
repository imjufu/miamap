# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminRoom::Members', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:member) { FactoryBot.create(:member) }

  within_subdomain 'guillamap' do
    describe 'GET /admin_room/members' do
      let(:action) { get '/admin_room/members' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the members page' do
          expect(response.body).to match('Membres')
        end
      end
    end

    describe 'GET /admin_room/members/1' do
      let(:action) { get "/admin_room/members/#{member.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the member page' do
          expect(response.body).to match(member.full_name)
        end
      end
    end

    describe 'GET /admin_room/members/new' do
      let(:action) { get '/admin_room/members/new' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the member creation page' do
          expect(response.body).to match('Nouveau·velle membre')
        end
      end
    end

    describe 'POST /admin_room/members' do
      let(:params) { FactoryBot.attributes_for(:member) }
      let(:action) { post '/admin_room/members', params: { member: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'creates a member' do
          expect { action }.to change(Member, :count).by(+1)
        end

        it 'redirects to the member page' do
          action
          expect(response).to redirect_to(admin_room_member_path(Member.last))
        end

        context 'with invalid params' do
          it 'displays an error' do
            post '/admin_room/members', params: { member: { first_name: '' } }
            expect(response.body).to match('Prénom doit être rempli')
          end
        end
      end
    end

    describe 'GET /admin_room/members/1/edit' do
      let(:action) { get "/admin_room/members/#{member.id}/edit" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          member
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the member edition page' do
          expect(response.body).to match(member.full_name)
          expect(response.body).to match('Enregistrer')
        end
      end
    end

    describe 'PUT/PATCH /admin_room/members/1' do
      let(:params) { { id: member.id, first_name: 'John' } }
      let(:action) { put "/admin_room/members/#{member.id}", params: { member: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          member
          sign_in(user)
        end

        it 'updates to the member' do
          expect do
            action
            member.reload
          end.to change(member, :first_name).from(member.first_name).to('John')
        end

        it 'redirects to the member page' do
          action
          expect(response).to redirect_to(admin_room_member_path(member))
        end
      end
    end

    describe 'DELETE /admin_room/members/1' do
      let(:action) { delete "/admin_room/members/#{member.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          member
          sign_in(user)
        end

        it 'deletes the member' do
          expect do
            action
            member.reload
          end.to change(member, :deleted?).from(false).to(true)
        end
      end
    end
  end
end
