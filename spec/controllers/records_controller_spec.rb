require 'rails_helper'

describe Api::RecordsController, type: :controller do
  let(:regular_user) { Fabricate(:user, role: :regular) }
  let(:manager) { Fabricate(:user, role: :manager) }
  let(:admin) { Fabricate(:user, role: :admin) }

  before { @users = [regular_user, manager, admin] }

  context 'INDEX' do
    before do
      Fabricate(:record, user: regular_user, date: 1.day.ago, time: 20.minutes.ago.seconds_since_midnight)
      Fabricate(:record, user: regular_user)
      Fabricate(:record, user: Fabricate(:user))
      Fabricate(:record, user: manager)
      Fabricate(:record, user: admin)
    end

    it 'returns only self records for regular user' do
      fake_session(regular_user)
      get :index, format: :json
      expect(json_response_body.count).to be == 2
    end

    it 'returns only self records for regular user' do
      fake_session(regular_user)
      get :index, date_from: 1.day.ago.to_date.to_s(:db), date_to: 1.day.ago.to_date.to_s(:db), format: :json
      expect(json_response_body.count).to be == 1
    end

    it 'returns only self records for manager' do
      fake_session(manager)
      get :index, format: :json
      expect(json_response_body.count).to be == 1
    end

    it 'returns all records for admin' do
      fake_session(admin)
      get :index, format: :json
      expect(json_response_body.count).to be == 5
    end
  end

  context 'CREATE' do
    it 'returns :created status' do
      @users.each do |user|
        fake_session(user)
        expect do
          post :create, record: Fabricate.attributes_for(:record)
        end.to change(Record, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    it 'returns :unprocessable_entity and returns errors as a hash' do
      fake_session(admin)
      post :create
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response_body).to be_instance_of(Hash)
    end

    it 'ignores user_id attribute if current_user is not admin' do
      fake_session(manager)
      post :create, record: Fabricate.attributes_for(:record, user: regular_user)
      expect(json_response_body['user_id']).to be == manager.id
    end

    it 'accepts user_id if current_user is admin' do
      fake_session(admin)
      post :create, record: Fabricate.attributes_for(:record, user: manager)
      expect(json_response_body['user_id']).to be == manager.id
    end
  end

  context 'UPDATE' do
    it 'returns :ok status' do
      @users.each do |user|
        fake_session(user)
        record = Fabricate(:record, user: user)
        put :update, id: record.id, record: { meal: 'carrot' }
        expect(response).to have_http_status(:ok)
        record.reload
        expect(record.meal).to eq('carrot')
      end
    end

    it 'returns :unprocessable_entity and returns errors as a hash' do
      fake_session(admin)
      record = Fabricate(:record, user: admin)
      put :update, id: record.id, record: { meal: nil }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response_body).to be_instance_of(Hash)
    end

    it 'returns :not_found for non-user record and not admin' do
      fake_session(manager)
      record = Fabricate(:record, user: regular_user)
      put :update, id: record.id, record: { meal: 'carrot' }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns :ok for non-user record if user is admin' do
      fake_session(admin)
      record = Fabricate(:record, user: manager)
      put :update, id: record.id, record: { meal: 'carrot' }
      expect(response).to have_http_status(:ok)
    end
  end

  context 'DESTROY' do
    it 'returns :ok status' do
      @users.each do |user|
        fake_session(user)
        record = Fabricate(:record, user: user)
        delete :destroy, id: record.id
        expect(response).to have_http_status(:ok)
      end
    end

    it 'returns :not_found for non-user record' do
      fake_session(manager)
      record = Fabricate(:record, user: regular_user)
      delete :destroy, id: record.id
      expect(response).to have_http_status(:not_found)
    end

    it 'returns :ok if is user is admin' do
      fake_session(admin)
      record = Fabricate(:record, user: regular_user)
      delete :destroy, id: record.id
      expect(response).to have_http_status(:ok)
    end
  end
end
