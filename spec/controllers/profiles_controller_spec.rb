require 'rails_helper'

describe Api::ProfilesController do
  let(:session) { Fabricate(:session) }

  before do
    allow(controller).to receive(:current_session).and_return(session)
  end

  context 'SHOW' do
    it 'returns :ok status' do
      get :show, format: :json
      expect(response).to have_http_status(:ok)
    end
  end

  context 'UPDATE' do
    it 'returns :ok status' do
      put :update, profile: { num_of_calories: 6.5 }, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'returns :unprocessable_entity status' do
      put :update, profile: { num_of_calories: -1 }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response_body['errors']).to be_instance_of(Hash)
    end
  end
end
