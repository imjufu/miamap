# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminRoom::Memberships', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:member) { FactoryBot.create(:member) }
  let(:membership_form) { FactoryBot.create(:membership_form) }
  let(:membership) { FactoryBot.create(:membership, member: member) }

  within_subdomain 'guillamap' do
    describe 'GET /admin_room/members/1/memberships/1' do
      let(:action) { get "/admin_room/members/#{member.id}/memberships/#{membership.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the membership page' do
          expect(response.body).to match("Adhésion n°#{membership.id}")
        end
      end
    end

    describe 'GET /admin_room/members/1/memberships/new' do
      let(:action) { get "/admin_room/members/#{member.id}/memberships/new" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the membership creation page' do
          expect(response.body).to match('Nouvelle adhésion')
        end
      end
    end

    describe 'POST /admin_room/members/1/memberships' do
      let(:params) do
        FactoryBot.attributes_for(:membership).merge(
          member_id: member.id, membership_form_id: membership_form.id
        )
      end
      let(:action) do
        post "/admin_room/members/#{member.id}/memberships", params: { membership: params }
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'creates a membership' do
          expect { action }.to change(Membership, :count).by(+1)
        end

        it 'redirects to the membership page' do
          action
          membership = Membership.last
          expect(response).to redirect_to(
            admin_room_member_membership_path(
              id: membership.id, member_id: membership.member_id
            )
          )
        end

        context 'with invalid params' do
          it 'displays an error' do
            post "/admin_room/members/#{member.id}/memberships", params: {
              membership: { membership_form_id: '' }
            }
            expect(response.body).to match(
              'Fiche d&#39;adhésion doit exister'
            )
          end
        end
      end
    end

    describe 'GET /admin_room/members/1/memberships/1/edit' do
      let(:action) do
        get "/admin_room/members/#{member.id}/memberships/#{membership.id}/edit"
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          membership
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the member edition page' do
          expect(response.body).to match("Adhésion n°#{membership.id}")
          expect(response.body).to match('Enregistrer')
        end
      end
    end

    describe 'PUT/PATCH /admin_room/members/1/memberships/1' do
      let(:new_membershiped_at) { Time.zone.local(2019, 4, 18, 12, 32, 14) }
      let(:params) do
        { id: membership.id, membershiped_at: new_membershiped_at }
      end
      let(:action) do
        put "/admin_room/members/#{member.id}/memberships/#{membership.id}", params: {
          membership: params
        }
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          membership
          sign_in(user)
        end

        it 'updates to the membership' do
          expect do
            action
            membership.reload
          end.to change(membership, :membershiped_at)
            .from(membership.membershiped_at)
            .to(new_membershiped_at)
        end

        it 'redirects to the membership page' do
          action
          expect(response).to redirect_to(
            admin_room_member_membership_path(
              id: membership.id, member_id: membership.member_id
            )
          )
        end
      end
    end

    describe 'DELETE /admin_room/members/1/memberships/1' do
      let(:action) do
        delete "/admin_room/members/#{member.id}/memberships/#{membership.id}"
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          membership
          sign_in(user)
        end

        it 'deletes the membership' do
          expect do
            action
            membership.reload
          end.to change(membership, :deleted?).from(false).to(true)
        end
      end
    end
  end
end
