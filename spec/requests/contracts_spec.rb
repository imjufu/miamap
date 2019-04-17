# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contracts', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:farmer) { FactoryBot.create(:farmer) }
  let(:contract) { FactoryBot.create(:contract, farmer: farmer) }
  let(:params) { FactoryBot.attributes_for(:contract) }

  within_subdomain 'guillamap' do
    describe 'GET /farmers/1/contracts/1/contracts/1' do
      let(:action) { get "/farmers/#{farmer.id}/contracts/#{contract.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the contract page' do
          expect(response.body).to match(contract.title)
        end
      end
    end

    describe 'GET /farmers/1/contracts/new' do
      let(:action) { get "/farmers/#{farmer.id}/contracts/new" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the contract creation page' do
          expect(response.body).to match('Nouveau contrat')
        end
      end
    end

    describe 'POST /farmers/1/contracts' do
      let(:params) { FactoryBot.attributes_for(:contract) }
      let(:action) { post "/farmers/#{farmer.id}/contracts", params: { contract: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'creates a contract' do
          expect { action }.to change(Contract, :count).by(+1)
        end

        it 'redirects to the contract page' do
          action
          contract = Contract.last
          expect(response).to redirect_to(
            farmer_contract_path(id: contract.id, farmer_id: contract.farmer_id)
          )
        end

        context 'with invalid params' do
          it 'displays an error' do
            post "/farmers/#{farmer.id}/contracts", params: { contract: { title: '' } }
            expect(response.body).to match('Titre doit être rempli')
          end
        end
      end
    end

    describe 'GET /farmers/1/contracts/1/edit' do
      let(:action) { get "/farmers/#{farmer.id}/contracts/#{contract.id}/edit" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          contract
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the farmer edition page' do
          expect(response.body).to match(contract.title)
          expect(response.body).to match('Enregistrer')
        end
      end
    end

    describe 'PUT/PATCH /farmers/1/contracts/1' do
      let(:params) { { id: contract.id, title: 'Été 2019' } }
      let(:action) { put "/farmers/#{farmer.id}/contracts/#{contract.id}", params: { contract: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          contract
          sign_in(user)
        end

        it 'updates to the contract' do
          expect do
            action
            contract.reload
          end.to change(contract, :title).from(contract.title).to('Été 2019')
        end

        it 'redirects to the contract page' do
          action
          expect(response).to redirect_to(
            farmer_contract_path(id: contract.id, farmer_id: contract.farmer_id)
          )
        end
      end
    end

    describe 'DELETE /farmers/1/contracts/1' do
      let(:action) { delete "/farmers/#{farmer.id}/contracts/#{contract.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          contract
          sign_in(user)
        end

        it 'deletes the contract' do
          expect do
            action
            contract.reload
          end.to change(contract, :deleted?).from(false).to(true)
        end
      end
    end
  end
end
