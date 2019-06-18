# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminRoom::Payments', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:subscription) { FactoryBot.create(:subscription) }
  let(:payment) { FactoryBot.create(:payment, subscription: subscription) }

  within_subdomain 'guillamap' do
    describe 'GET /admin_room/subscriptions/1/payments/new' do
      let(:action) { get "/admin_room/subscriptions/#{subscription.id}/payments/new" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the payment creation page' do
          expect(response.body).to match('Nouveau paiement')
        end
      end
    end

    describe 'POST /admin_room/subscriptions/1/payments' do
      let(:params) { FactoryBot.attributes_for(:payment) }
      let(:action) do
        post "/admin_room/subscriptions/#{subscription.id}/payments", params: {
          payment: params
        }
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'creates a payment' do
          expect { action }.to change(Payment, :count).by(+1)
        end

        it 'redirects to the payment page' do
          action
          payment = Payment.last
          expect(response).to redirect_to(
            admin_room_subscription_payment_path(
              id: payment.id, subscription_id: payment.subscription_id
            )
          )
        end

        context 'with invalid params' do
          it 'displays an error' do
            post "/admin_room/subscriptions/#{subscription.id}/payments", params: {
              payment: { amount: '' }
            }
            expect(response.body).to match('Montant n&#39;est pas un nombre')
          end
        end
      end
    end

    describe 'GET /admin_room/subscriptions/1/payments/1/edit' do
      let(:action) do
        get "/admin_room/subscriptions/#{subscription.id}/payments/#{payment.id}/edit"
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          payment
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the payment edition page' do
          expect(response.body).to match(payment.amount.to_s)
          expect(response.body).to match('Enregistrer')
        end
      end
    end

    describe 'PUT/PATCH /admin_room/subscriptions/1/payments/1' do
      let(:params) { { id: payment.id, amount: 110 } }
      let(:action) do
        put "/admin_room/subscriptions/#{subscription.id}/payments/#{payment.id}",
            params: { payment: params }
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          payment
          sign_in(user)
        end

        it 'updates to the payment' do
          expect do
            action
            payment.reload
          end.to change(payment, :amount).from(payment.amount).to(
            Money.new(11_000)
          )
        end

        it 'redirects to the payment page' do
          action
          expect(response).to redirect_to(
            admin_room_subscription_payment_path(
              id: payment.id, subscription_id: payment.subscription_id
            )
          )
        end
      end
    end

    describe 'DELETE /admin_room/subscriptions/1/payments/1' do
      let(:action) do
        delete "/admin_room/subscriptions/#{subscription.id}/payments/#{payment.id}"
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          payment
          sign_in(user)
        end

        it 'deletes the payment' do
          expect do
            action
          end.to change(Payment, :count).by(-1)
        end
      end
    end
  end
end
