module Api
  class ProfilesController < ApiController
    def show
      render json: current_user
    end

    def update
      if current_user.update_attributes(profile_strong_params)
        render json: current_user
      else
        render json: { errors: current_user.errors }, status: :unprocessable_entity
      end
    end

    private

    def profile_strong_params
      params.fetch(:profile, {}).permit(:email, :num_of_calories)
    end
  end
end
