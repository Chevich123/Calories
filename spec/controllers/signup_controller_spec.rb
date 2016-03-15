require 'rails_helper'

describe Api::SignupController do
  context 'CREATE' do
    it 'returns :created status' do
      post :create, signup: Fabricate.attributes_for(:user)
      expect(response).to have_http_status(:created)
    end

    it 'creates a User' do
      expect do
        post :create, signup: Fabricate.attributes_for(:user)
      end.to change(User, :count).by(1)
    end

    it 'returns :unprocessable_entity status' do
      post :create, {}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'response have errors key and it is an array' do
      post :create, {}
      expect(json_response_body).to have_key('errors')
      expect(json_response_body['errors']).to be_instance_of(Hash)
    end
  end
end
