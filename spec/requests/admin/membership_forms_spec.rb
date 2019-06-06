# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin/MembershipForms', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:membership_form) { FactoryBot.create(:membership_form) }

  within_subdomain 'guillamap' do
    describe 'GET /admin/membership_forms' do
      let(:action) { get '/admin/membership_forms' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the membership forms page' do
          expect(response.body).to match('Fiches d&#39;adhésion')
        end
      end
    end

    describe 'GET /admin/membership_forms/1' do
      let(:action) { get "/admin/membership_forms/#{membership_form.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the membership form page' do
          expect(response.body).to match(membership_form.title)
        end
      end
    end

    describe 'GET /admin/membership_forms/new' do
      let(:action) { get '/admin/membership_forms/new' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the membership form creation page' do
          expect(response.body).to match('Nouvelle fiche d&#39;adhésion')
        end
      end
    end

    describe 'POST /admin/membership_forms' do
      let(:params) { FactoryBot.attributes_for(:membership_form) }
      let(:action) do
        post '/admin/membership_forms', params: { membership_form: params }
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'creates a membership form' do
          expect { action }.to change(MembershipForm, :count).by(+1)
        end

        it 'redirects to the membership form page' do
          action
          expect(response).to redirect_to(admin_membership_form_path(MembershipForm.last))
        end

        context 'with invalid params' do
          it 'displays an error' do
            post '/admin/membership_forms', params: { membership_form: { title: '' } }
            expect(response.body).to match('Titre doit être rempli')
          end
        end
      end
    end

    describe 'GET /admin/membership_forms/1/edit' do
      before { membership_form }

      let(:action) { get "/admin/membership_forms/#{membership_form.id}/edit" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the membership form edition page' do
          expect(response.body).to match(membership_form.title)
          expect(response.body).to match('Enregistrer')
        end
      end
    end

    describe 'PUT/PATCH /admin/membership_forms/1' do
      let(:params) { { id: membership_form.id, title: 'Adhésion 2019' } }
      let(:action) do
        put "/admin/membership_forms/#{membership_form.id}",
            params: { membership_form: params }
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          membership_form
          sign_in(user)
        end

        it 'updates to the membership form' do
          expect do
            action
            membership_form.reload
          end.to change(membership_form, :title)
            .from(membership_form.title).to('Adhésion 2019')
        end

        it 'redirects to the membership form page' do
          action
          expect(response).to redirect_to(admin_membership_form_path(membership_form))
        end
      end
    end

    describe 'DELETE /admin/membership_forms/1' do
      let(:action) { delete "/admin/membership_forms/#{membership_form.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          membership_form
          sign_in(user)
        end

        it 'deletes the membership form' do
          expect do
            action
            membership_form.reload
          end.to change(membership_form, :deleted?).from(false).to(true)
        end
      end
    end
  end
end
