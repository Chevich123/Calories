require 'rails_helper'

describe Api::UsersController do
  let(:regular_user) { Fabricate(:user, role: :regular) }
  let(:manager) { Fabricate(:user, role: :manager) }
  let(:admin) { Fabricate(:user, role: :admin) }

  describe 'INDEX' do
    before { Fabricate(:user, role: :regular) }

    it 'returns :ok for regular user' do
      fake_session(regular_user)
      get :index, format: :json
      expect(response).to have_http_status(:ok)
      expect(json_response_body.count).to eq(1)
    end

    it 'returns :ok for manager' do
      fake_session(manager)
      get :index, format: :json
      expect(response).to have_http_status(:ok)
      expect(json_response_body.count).to eq(User.where(role: :regular).count)
    end

    it 'returns :ok for admin' do
      fake_session(admin)
      get :index, format: :json
      expect(response).to have_http_status(:ok)
      expect(json_response_body.count).to eq(User.count)
    end
  end

  describe 'SHOW' do
    describe 'by regular_user' do
      before { fake_session(regular_user) }
      it 'returns :ok for yourselves' do
        get :show, id: regular_user.id, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :forbidden for another users' do
        another_regular = Fabricate(:user, role: :regular)
        get :show, id: another_regular.id, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'by manager' do
      before { fake_session(manager) }
      it 'returns :ok for regular' do
        get :show, id: manager.id, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :ok for manager' do
        get :show, id: regular_user.id, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :forbidden for admin' do
        get :show, id: admin.id, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'by admin' do
      before { fake_session(admin) }
      it 'returns :ok for regular_user' do
        get :show, id: regular_user.id, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :ok for manager' do
        get :show, id: manager.id, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :ok for admin' do
        get :show, id: admin.id, format: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'CREATE' do
    describe 'by regular user' do
      before { fake_session(regular_user) }

      it 'returns :created for regular user' do
        post :create, user: Fabricate.attributes_for(:user, role: :regular), format: :json
        expect(response).to have_http_status(:created)
      end

      it 'returns :forbidden for manager' do
        post :create, user: Fabricate.attributes_for(:user, role: :manager), format: :json
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns :forbidden for admin' do
        post :create, user: Fabricate.attributes_for(:user, role: :admin), format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'by manager' do
      before { fake_session(manager) }
      it 'returns :created for regular_user' do
        post :create, user: Fabricate.attributes_for(:user, role: :regular), format: :json
        expect(response).to have_http_status(:created)
      end

      it 'returns :created for manager' do
        post :create, user: Fabricate.attributes_for(:user, role: :manager), format: :json
        expect(response).to have_http_status(:created)
      end

      it 'returns :forbidden for admin' do
        post :create, user: Fabricate.attributes_for(:user, role: :admin), format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'by manager' do
      before { fake_session(admin) }
      it 'returns :created for regular_user' do
        post :create, user: Fabricate.attributes_for(:user, role: :regular), format: :json
        expect(response).to have_http_status(:created)
      end

      it 'returns :created for manager' do
        post :create, user: Fabricate.attributes_for(:user, role: :manager), format: :json
        expect(response).to have_http_status(:created)
      end

      it 'returns :created for admin' do
        post :create, user: Fabricate.attributes_for(:user, role: :admin), format: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'UPDATE' do
    describe 'for regular user' do
      before { fake_session(regular_user) }
      it 'returns :ok for themselves' do
        put :update, id: regular_user.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:ok)
      end
      it 'returns :forbidden for another regular' do
        another_user = Fabricate(:user, role: :regular)
        put :update, id: another_user.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:forbidden)
      end
      it 'returns :forbidden for manager' do
        put :update, id: manager.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:forbidden)
      end
      it 'returns :forbidden for admin' do
        put :update, id: admin.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'for manager' do
      before { fake_session(manager) }
      it 'returns :ok for regular_user' do
        put :update, id: regular_user.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :ok for manager' do
        put :update, id: manager.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :forbidden for admin' do
        put :update, id: admin.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'for admin' do
      before { fake_session(admin) }
      it 'returns :ok for regular_user' do
        put :update, id: regular_user.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :ok for manager' do
        put :update, id: manager.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :ok for admin' do
        put :update, id: admin.id, user: { email: 'updated@example.com' }, format: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DESTROY' do
    describe 'for regular user' do
      before { fake_session(regular_user) }
      it 'returns :ok for themselves' do
        delete :destroy, id: regular_user.id, format: :json
        expect(response).to have_http_status(:ok)
      end
      it 'returns :forbidden for another regular' do
        another_user = Fabricate(:user, role: :regular)
        delete :destroy, id: another_user.id, format: :json
        expect(response).to have_http_status(:forbidden)
      end
      it 'returns :forbidden for manager' do
        delete :destroy, id: manager.id, format: :json
        expect(response).to have_http_status(:forbidden)
      end
      it 'returns :forbidden for admin' do
        delete :destroy, id: admin.id, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'for manager' do
      before { fake_session(manager) }
      it 'returns :ok for regular_user' do
        delete :destroy, id: regular_user.id, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :ok for manager' do
        delete :destroy, id: manager.id, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :forbidden for admin' do
        delete :destroy, id: admin.id, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'for admin' do
      before { fake_session(admin) }
      it 'returns :ok for regular_user' do
        delete :destroy, id: regular_user.id, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :ok for manager' do
        delete :destroy, id: manager.id, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns :ok for admin' do
        delete :destroy, id: admin.id, format: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
