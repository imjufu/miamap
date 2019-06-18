# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminRoom::Producers', type: :request do
  let(:user) { FactoryBot.create(:user, profile: Profile::ADMIN) }
  let(:producer) { FactoryBot.create(:producer) }

  within_subdomain 'guillamap' do
    describe 'GET /admin_room/producers' do
      let(:action) { get '/admin_room/producers' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the producers page' do
          expect(response.body).to match('Producteur·trice')
        end
      end
    end

    describe 'GET /admin_room/producers/1' do
      let(:action) { get "/admin_room/producers/#{producer.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the producer page' do
          expect(response.body).to match(producer.name)
        end
      end
    end

    describe 'GET /admin_room/producers/new' do
      let(:action) { get '/admin_room/producers/new' }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the producer creation page' do
          expect(response.body).to match('Nouveau·lle producteur·trice')
        end
      end
    end

    describe 'POST /admin_room/producers' do
      let(:params) { FactoryBot.attributes_for(:producer) }
      let(:action) { post '/admin_room/producers', params: { producer: params } }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before { sign_in(user) }

        it 'creates a producer' do
          expect { action }.to change(Producer, :count).by(+1)
        end

        it 'redirects to the producer page' do
          action
          expect(response).to redirect_to(admin_room_producer_path(Producer.last))
        end

        context 'with invalid params' do
          it 'displays an error' do
            post '/admin_room/producers', params: { producer: { name: '' } }
            expect(response.body).to match('Nom doit être rempli')
          end
        end
      end
    end

    describe 'GET /admin_room/producers/1/edit' do
      let(:action) { get "/admin_room/producers/#{producer.id}/edit" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          producer
          sign_in(user)
          action
        end

        it 'responds with status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'displays the producer edition page' do
          expect(response.body).to match(producer.name)
          expect(response.body).to match('Enregistrer')
        end
      end
    end

    describe 'PUT/PATCH /admin_room/producers/1' do
      let(:params) { { id: producer.id, name: 'John' } }
      let(:action) do
        put "/admin_room/producers/#{producer.id}", params: { producer: params }
      end

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          producer
          sign_in(user)
        end

        it 'updates to the producer' do
          expect do
            action
            producer.reload
          end.to change(producer, :name).from(producer.name).to('John')
        end

        it 'redirects to the producer page' do
          action
          expect(response).to redirect_to(admin_room_producer_path(producer))
        end
      end
    end

    describe 'DELETE /admin_room/producers/1' do
      let(:action) { delete "/admin_room/producers/#{producer.id}" }

      it_behaves_like 'a private action'

      context 'when the user is logged in as an admin' do
        before do
          producer
          sign_in(user)
        end

        it 'deletes the producer' do
          expect do
            action
            producer.reload
          end.to change(producer, :deleted?).from(false).to(true)
        end
      end
    end
  end
end
