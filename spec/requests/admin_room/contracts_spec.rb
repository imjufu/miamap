# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminRoom::Contracts', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:producer) { FactoryBot.create(:producer) }
  let(:contract) { FactoryBot.create(:contract, producer: producer) }

  within_subdomain 'guillamap' do
    describe 'GET /admin_room/producers/1/contracts/1' do
      let(:action) { get "/admin_room/producers/#{producer.id}/contracts/#{contract.id}" }

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

    describe 'GET /admin_room/producers/1/contracts/new' do
      let(:action) { get "/admin_room/producers/#{producer.id}/contracts/new" }

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

    describe 'POST /admin_room/producers/1/contracts' do
      let(:params) { FactoryBot.attributes_for(:contract) }
      let(:action) do
        post "/admin_room/producers/#{producer.id}/contracts", params: { contract: params }
      end

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
            admin_room_producer_contract_path(
              id: contract.id, producer_id: contract.producer_id
            )
          )
        end

        context 'with invalid params' do
          it 'displays an error' do
            post "/admin_room/producers/#{producer.id}/contracts", params: {
              contract: { title: '' }
            }
            expect(response.body).to match('Titre doit être rempli')
          end
        end
      end
    end

    describe 'GET /admin_room/producers/1/contracts/1/edit' do
      let(:action) do
        get "/admin_room/producers/#{producer.id}/contracts/#{contract.id}/edit"
      end

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

        it 'displays the producer edition page' do
          expect(response.body).to match(contract.title)
          expect(response.body).to match('Enregistrer')
        end
      end
    end

    describe 'PUT/PATCH /admin_room/producers/1/contracts/1' do
      let(:params) { { id: contract.id, title: 'Été 2019' } }
      let(:action) do
        put "/admin_room/producers/#{producer.id}/contracts/#{contract.id}", params: {
          contract: params
        }
      end

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
            admin_room_producer_contract_path(
              id: contract.id, producer_id: contract.producer_id
            )
          )
        end
      end
    end

    describe 'DELETE /admin_room/producers/1/contracts/1' do
      let(:action) do
        delete "/admin_room/producers/#{producer.id}/contracts/#{contract.id}"
      end

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
