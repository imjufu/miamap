# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin/Users', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }

  within_subdomain 'guillamap' do
    describe 'GET /admin/users' do
      let(:action) { get '/admin/users' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the users page' do
          expect(response.body).to match('Utilisateur·trices')
        end
      end
    end

    describe 'GET /admin/users/1' do
      let(:action) { get "/admin/users/#{user.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the user page' do
          expect(response.body).to match(user.full_name)
        end
      end
    end

    describe 'GET /admin/users/new' do
      let(:action) { get '/admin/users/new' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the user creation page' do
          expect(response.body).to match('Nouvel·le utilisateur·trice')
        end
      end
    end

    describe 'POST /admin/users' do
      let(:params) { FactoryBot.attributes_for(:user) }
      let(:action) { post '/admin/users', params: { user: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'creates a user' do
          expect { action }.to change(User, :count).by(+1)
        end

        it 'redirects to the user page' do
          action
          expect(response).to redirect_to(admin_user_path(User.last))
        end

        context 'with invalid params' do
          it 'displays an error' do
            post '/admin/users', params: { user: { first_name: '' } }
            expect(response.body).to match('Prénom doit être rempli')
          end
        end
      end
    end

    describe 'GET /admin/users/1/edit' do
      before { user }

      let(:action) { get "/admin/users/#{user.id}/edit" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the user edition page' do
          expect(response.body).to match(user.full_name)
          expect(response.body).to match('Enregistrer')
        end
      end
    end

    describe 'PUT/PATCH /admin/users/1' do
      let(:params) { { id: user.id, first_name: 'John' } }
      let(:action) { put "/admin/users/#{user.id}", params: { user: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          user
          sign_in(user)
        end

        it 'updates to the user' do
          expect do
            action
            user.reload
          end.to change(user, :first_name).from(user.first_name).to('John')
        end

        it 'redirects to the user page' do
          action
          expect(response).to redirect_to(admin_user_path(user))
        end
      end
    end

    describe 'DELETE /admin/users/1' do
      let(:action) { delete "/admin/users/#{user.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          user
          sign_in(user)
        end

        it 'deletes the user' do
          expect do
            action
            user.reload
          end.to change(user, :deleted?).from(false).to(true)
        end
      end
    end
  end
end
