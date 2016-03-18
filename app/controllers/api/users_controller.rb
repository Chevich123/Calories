module Api
  class UsersController < ApiController
    before_action :check_role_permissions!, except: [:index, :create]
    before_action :create_user_permissions!, only: :create

    def index
      @users = if current_user.regular?
                 [current_user]
               elsif current_user.manager?
                 User.where(role: :regular).all
               else
                 User.all
               end
    end

    def show
    end

    def create
      @user = User.new(create_user_strong_params)
      @user.role = :regular
      if @user.save
        render :show, status: :created
      else
        render :show, status: :unprocessable_entity
      end
    end

    def update
      if @user.update_attributes(update_user_strong_params)
        render :show
      else
        render :show, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      render json: nil
    end

    private

    def create_user_strong_params
      params.fetch(:user, {}).permit(:email, :password, :password_confirmation, :num_of_calories, :role)
    end

    def update_user_strong_params
      if current_user.admin?
        params.fetch(:user, {}).permit(:email, :num_of_calories, :role)
      else
        params.fetch(:user, {}).permit(:email, :num_of_calories)
      end
    end

    def create_user_permissions!
      return unless create_user_strong_params[:role].present?
      render_forbidden if current_user.regular? && !check_role_attribute(:regular)
      render_forbidden if current_user.manager? && check_role_attribute(:admin)
    end

    def check_role_permissions!
      define_user
      render_forbidden if current_user.regular? && current_user.id != @user.id
      return unless current_user.manager?
      render_forbidden if @user.admin?
      render_forbidden if @user.manager? && current_user.id != @user.id
    end

    def define_user
      @user = User.find(params.require(:id))
      render(json: nil, status: :render_404) unless @user.present?
    end

    def check_role_attribute(sample)
      sample.to_s.casecmp(create_user_strong_params[:role].to_s).zero?
    end
  end
end
