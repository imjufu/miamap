# frozen_string_literal: true

shared_examples_for 'a private action' do
  context 'when the user is not logged in' do
    before { action }
    it 'redirects to login page' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

shared_examples_for 'a private webservice' do
  context 'when the user is not logged in' do
    before { action }
    it 'responds with status code 200' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
