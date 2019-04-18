# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Farmers', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:farmer) { FactoryBot.create(:farmer) }

  within_subdomain 'guillamap' do
    describe 'GET /farmers' do
      let(:action) { get '/farmers' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the farmers page' do
          expect(response.body).to match('Paysan·ne·s')
        end
      end
    end

    describe 'GET /farmers/1' do
      let(:action) { get "/farmers/#{farmer.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the farmer page' do
          expect(response.body).to match(farmer.name)
        end
      end
    end

    describe 'GET /farmers/new' do
      let(:action) { get '/farmers/new' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the farmer creation page' do
          expect(response.body).to match('Nouveau·lle paysan·ne')
        end
      end
    end

    describe 'POST /farmers' do
      let(:params) { FactoryBot.attributes_for(:farmer) }
      let(:action) { post '/farmers', params: { farmer: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'creates a farmer' do
          expect { action }.to change(Farmer, :count).by(+1)
        end

        it 'redirects to the farmer page' do
          action
          expect(response).to redirect_to(Farmer.last)
        end

        context 'with invalid params' do
          it 'displays an error' do
            post '/farmers', params: { farmer: { name: '' } }
            expect(response.body).to match('Nom doit être rempli')
          end
        end
      end
    end

    describe 'GET /farmers/1/edit' do
      let(:action) { get "/farmers/#{farmer.id}/edit" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          farmer
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the farmer edition page' do
          expect(response.body).to match(farmer.name)
          expect(response.body).to match('Enregistrer')
        end
      end
    end

    describe 'PUT/PATCH /farmers/1' do
      let(:params) { { id: farmer.id, name: 'John' } }
      let(:action) { put "/farmers/#{farmer.id}", params: { farmer: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          farmer
          sign_in(user)
        end

        it 'updates to the farmer' do
          expect do
            action
            farmer.reload
          end.to change(farmer, :name).from(farmer.name).to('John')
        end

        it 'redirects to the farmer page' do
          action
          expect(response).to redirect_to(farmer)
        end
      end
    end

    describe 'DELETE /farmers/1' do
      let(:action) { delete "/farmers/#{farmer.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          farmer
          sign_in(user)
        end

        it 'deletes the farmer' do
          expect do
            action
            farmer.reload
          end.to change(farmer, :deleted?).from(false).to(true)
        end
      end
    end
  end
end
