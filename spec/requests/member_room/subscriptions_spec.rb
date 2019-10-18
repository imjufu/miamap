# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MemberRoom::Subscriptions', type: :request do
  let(:subscription) { FactoryBot.create(:subscription, member: member) }
  let(:member) { FactoryBot.create(:member) }

  within_subdomain 'guillamap' do
    describe 'GET /member_room/subscriptions' do
      let(:action) { get '/member_room/subscriptions' }

      it_behaves_like 'a private action', :member

      context 'when the member is logged in as an admin' do
        before do
          sign_in(member)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the subscriptions page' do
          expect(response.body).to match('Mes contrats')
        end
      end
    end

    describe 'GET /member_room/subscriptions/1' do
      let(:action) { get "/member_room/subscriptions/#{subscription.id}" }

      it_behaves_like 'a private action', :member

      context 'when the member is logged in as an admin' do
        before do
          sign_in(member)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the subscription page' do
          expect(response.body).to match(subscription.contract.title)
        end
      end
    end
  end
end
