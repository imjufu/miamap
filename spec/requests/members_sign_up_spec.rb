# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MembersSignUp', type: :request do
  let(:member_registration_request) { FactoryBot.create(:member_registration_request) }
  let(:start_registration) do
    post '/members_sign_up/step_1', params: { member_registration_request: { email: Faker::Internet.email } }
  end

  within_subdomain 'guillamap' do
    describe 'GET /members_sign_up/step_1' do
      let(:action) { get '/members_sign_up/step_1' }

      before { action }

      it 'responds with status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'displays the step 1 page' do
        expect(response.body).to match('Nous sommes très heureux de vous accueillir parmi nous…')
      end
    end

    describe 'POST /members_sign_up/step_1' do
      let(:params) { { member_registration_request: { email: Faker::Internet.email } } }
      let(:action) { post '/members_sign_up/step_1', params: params }

      it 'creates a MemberRegistrationRequest' do
        expect { action }.to change(MemberRegistrationRequest, :count).by(+1)
      end

      it 'redirects to the step 2' do
        action
        expect(response).to redirect_to(members_sign_up_step_2_path)
      end

      context 'with invalid params' do
        let(:params) { { member_registration_request: { email: '' } } }

        it 'displays an error' do
          action
          expect(response.body).to match('Courriel n&#39;est pas valide')
        end
      end
    end

    describe 'GET /members_sign_up/step_2' do
      let(:action) { get '/members_sign_up/step_2' }

      before do
        start_registration
        action
      end

      it 'responds with status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'displays the step 2 page' do
        expect(response.body).to match('Comment vous appelez-vous')
      end
    end

    describe 'PATCH /members_sign_up/step_2' do
      let(:params) { { member_registration_request: { first_name: 'Luke', last_name: Faker::Name.last_name, date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65) } } }
      let(:action) { patch '/members_sign_up/step_2', params: params }

      before { start_registration }

      it 'updates the MemberRegistrationRequest' do
        registration_request = MemberRegistrationRequest.last
        expect do
          action
          registration_request.reload
        end.to change(registration_request, :first_name).to('Luke')
      end

      it 'redirects to the step 3' do
        action
        expect(response).to redirect_to(members_sign_up_step_3_path)
      end

      context 'with invalid params' do
        let(:params) { { member_registration_request: { first_name: '' } } }

        it 'displays an error' do
          action
          expect(response.body).to match('Pr.*nom doit .*tre rempli\(e\)')
        end
      end
    end

    describe 'GET /members_sign_up/step_3' do
      let(:action) { get '/members_sign_up/step_3' }

      before do
        start_registration
        registration_request = MemberRegistrationRequest.last
        registration_request.update(
          first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
          date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65), step: 2
        )
        action
      end

      it 'responds with status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'displays the step 3 page' do
        expect(response.body).to match('Où habitez-vous ?')
      end
    end

    describe 'PATCH /members_sign_up/step_3' do
      let(:params) { { member_registration_request: { address: '39 Rue du Test', postal_code: '69007', city: 'Lyon' } } }
      let(:action) { patch '/members_sign_up/step_3', params: params }

      before do
        start_registration
        registration_request = MemberRegistrationRequest.last
        registration_request.update(
          first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
          date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65), step: 2
        )
      end

      it 'updates the MemberRegistrationRequest' do
        registration_request = MemberRegistrationRequest.last
        expect do
          action
          registration_request.reload
        end.to change(registration_request, :address).to('39 Rue du Test')
      end

      it 'redirects to the step 4' do
        action
        expect(response).to redirect_to(members_sign_up_step_4_path)
      end

      context 'with invalid params' do
        let(:params) { { member_registration_request: { address: '' } } }

        it 'displays an error' do
          action
          expect(response.body).to match('Adresse doit .*tre rempli\(e\)')
        end
      end
    end

    describe 'GET /members_sign_up/step_4' do
      let(:action) { get '/members_sign_up/step_4' }

      before do
        start_registration
        registration_request = MemberRegistrationRequest.last
        registration_request.update(
          first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
          date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
          address: Faker::Address.street_address, postal_code: Faker::Address.postcode,
          city: Faker::Address.city, step: 3
        )
        action
      end

      it 'responds with status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'displays the step 4 page' do
        expect(response.body).to match('votre pr.*-inscription vient de nous .*tre transmise')
      end
    end

    describe 'DELETE /members_sign_up' do
      let(:action) { delete '/members_sign_up' }

      before do
        start_registration
      end

      it 'deletes the MemberRegistrationRequest' do
        expect { action }.to change(MemberRegistrationRequest, :count).by(-1)
      end
    end
  end
end
