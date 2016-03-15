require 'rails_helper'

describe Api::SessionsController do
  let(:pass) { '123123123' }
  let(:user) { Fabricate(:user, password: pass, password_confirmation: pass) }
  let(:session) { Fabricate(:session, user: user) }

  context 'CREATE' do
    it 'returns :created status' do
      post :create, session: { email: user.email, password: pass }, format: :json
      expect(response).to have_http_status(:created)
    end

    it 'creates a Session' do
      expect do
        post :create, session: { email: user.email, password: pass }, format: :json
      end.to change(Session, :count).by(1)
    end

    it 'returns :unauthorized status' do
      post :create, session: { email: user.email, password: 'invalid' }, format: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'DESTROY' do
    before do
      allow(controller).to receive(:current_session).and_return(session)
    end

    it 'returns :ok status' do
      delete :destroy, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'destroys a Session' do
      expect do
        delete :destroy, format: :json
      end.to change(Session, :count).by(-1)
    end
  end
end
