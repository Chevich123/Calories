Rails.application.routes.draw do
  scope path: '/api', module: 'api' do
    resources :signup, only: :create
    resource :session, only: [:create, :destroy]
    resource :profile, only: [:show, :update]
    resources :users, only: [:index, :show, :create, :update, :destroy]
    resources :records, only: [:index, :show, :create, :update, :destroy]
  end

  root to: 'application#main'
end
