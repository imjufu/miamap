# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Members', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:member) { FactoryBot.create(:member) }

  within_subdomain 'guillamap' do
    describe 'GET /members' do
      let(:action) { get '/members' }

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

    describe 'GET /members/1' do
      let(:action) { get "/members/#{member.id}" }

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

    describe 'GET /members/new' do
      let(:action) { get '/members/new' }

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
          expect(response.body).to match('Nouveau·lle membre')
        end
      end
    end

    describe 'POST /members' do
      let(:params) { FactoryBot.attributes_for(:member) }
      let(:action) { post '/members', params: { member: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'creates a member' do
          expect { action }.to change(Member, :count).by(+1)
        end

        it 'redirects to the member page' do
          action
          expect(response).to redirect_to(Member.last)
        end

        context 'with invalid params' do
          it 'displays an error' do
            post '/members', params: { member: { first_name: '' } }
            expect(response.body).to match('Prénom doit être rempli')
          end
        end
      end
    end

    describe 'GET /members/1/edit' do
      let(:action) { get "/members/#{member.id}/edit" }

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

    describe 'PUT/PATCH /members/1' do
      let(:params) { { id: member.id, first_name: 'John' } }
      let(:action) { put "/members/#{member.id}", params: { member: params } }

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
          expect(response).to redirect_to(member)
        end
      end
    end

    describe 'DELETE /members/1' do
      let(:action) { delete "/members/#{member.id}" }

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
