module Api
  class SessionsController < ApiController
    skip_before_action :authenticate_user!, only: :create

    def create
      user = User.where(email: user_strong_params[:email]).take
      if user.present? && user.valid_password?(user_strong_params[:password])
        render json: user.sessions.create, status: :created
      else
        render json: nil, status: :unauthorized
      end
    end

    def destroy
      current_session.destroy
      render json: nil, status: :ok
    end

    private

    def user_strong_params
      params.fetch(:session, {}).permit(:email, :password)
    end
  end
end
