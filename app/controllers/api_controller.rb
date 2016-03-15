class ApiController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def current_user
    @current_user ||= current_session.try(&:user)
  end
  helper_method :current_user

  protected

  def authenticate_user!
    render json: nil, status: :unauthorized unless current_user
  end

  def current_session
    @current_session ||= Session.where(authorization_token: request.headers['X-Auth-Secret']).take
  end

  def render_404
    render json: nil, status: :not_found
  end
end
