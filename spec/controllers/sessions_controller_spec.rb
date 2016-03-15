require 'rails_helper'

RSpec.describe Api::SessionsController do
  let(:pass) { '123123123' }
  let(:user) { Fabricate(:user, password: pass, password_confirmation: pass) }
  let(:session) { Fabricate(:session, user: user) }

  context '.create' do
    it 'returns :created status' do
      post :create, session: { email: user.email, password: pass }
      expect(response).to have_http_status(:created)
    end

    it 'creates a Session' do
      expect do
        post :create, session: { email: user.email, password: pass }
      end.to change(Session, :count).by(1)
    end

    it 'returns :unauthorized status' do
      post :create, session: { email: user.email, password: 'invalid' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context '.destroy' do
    before(:each) do
      allow(controller).to receive(:current_session).and_return(session)
    end

    it 'returns :ok status' do
      delete :destroy
      expect(response).to have_http_status(:ok)
    end

    it 'destroys a Session' do
      expect do
        delete :destroy
      end.to change(Session, :count).by(-1)
    end
  end
end
