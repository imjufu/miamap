# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminRoom::Subscriptions', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:subscription) { FactoryBot.create(:subscription) }
  let(:contract) { FactoryBot.create(:contract) }
  let(:member) { FactoryBot.create(:member) }

  within_subdomain 'guillamap' do
    describe 'GET /admin_room/subscriptions' do
      let(:action) { get '/admin_room/subscriptions' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the subscriptions page' do
          expect(response.body).to match('Souscriptions')
        end
      end
    end

    describe 'GET /admin_room/subscriptions/1' do
      let(:action) { get "/admin_room/subscriptions/#{subscription.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the subscription page' do
          expect(response.body).to match("Souscription n°#{subscription.id}")
        end
      end
    end

    describe 'GET /admin_room/subscriptions/1/preview' do
      let(:action) { get "/admin_room/subscriptions/#{subscription.id}/preview" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the subscription preview before signing page' do
          expect(response.body).to match(subscription.contract.title)
        end
      end
    end

    describe 'GET /admin_room/subscriptions/new' do
      let(:action) { get '/admin_room/subscriptions/new' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the subscription creation page' do
          expect(response.body).to match('Nouvelle souscription')
        end
      end
    end

    describe 'POST /admin_room/subscriptions' do
      let(:params) do
        FactoryBot.attributes_for(:subscription).merge(
          member_id: member.id, contract_id: contract.id
        )
      end
      let(:action) { post '/admin_room/subscriptions', params: { subscription: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          contract
          member
          sign_in(user)
        end

        it 'creates a subscription' do
          expect { action }.to change(Subscription, :count).by(+1)
        end

        it 'redirects to the subscription page' do
          action
          expect(response).to redirect_to(admin_room_subscription_path(Subscription.last))
        end

        context 'with invalid params' do
          it 'displays an error' do
            post '/admin_room/subscriptions', params: { subscription: { member_id: '' } }
            expect(response.body).to match('Membre doit exister')
          end
        end
      end
    end

    describe 'PUT/PATCH /admin_room/subscriptions/1' do
      let(:new_subscribed_at) { Time.zone.local(2019, 4, 18, 12, 32, 14) }
      let(:params) { { id: subscription.id, subscribed_at: new_subscribed_at } }
      let(:action) do
        put "/admin_room/subscriptions/#{subscription.id}", params: {
          subscription: params
        }
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          subscription
          sign_in(user)
        end

        it 'updates to the subscription' do
          expect do
            action
            subscription.reload
          end.to change(subscription, :subscribed_at)
            .from(subscription.subscribed_at)
            .to(new_subscribed_at)
        end

        it 'redirects to the subscription page' do
          action
          expect(response).to redirect_to(admin_room_subscription_path(subscription))
        end
      end
    end

    describe 'DELETE /admin_room/subscriptions/1' do
      let(:action) { delete "/admin_room/subscriptions/#{subscription.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          subscription
          sign_in(user)
        end

        it 'deletes the subscription' do
          expect do
            action
            subscription.reload
          end.to change(subscription, :deleted?).from(false).to(true)
        end
      end
    end
  end
end
