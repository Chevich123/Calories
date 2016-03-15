module Api
  class SignupController < ApiController
    skip_before_action :authenticate_user!

    def create
      user = User.create(user_params)
      user.role = :regular

      if user.save
        render json: user, status: :created
      else
        render json: { errors: user.errors, code: 422 }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.fetch(:signup, {}).permit(:email, :password, :password_confirmation)
    end
  end
end
