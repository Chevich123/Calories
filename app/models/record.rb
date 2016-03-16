class Record < ActiveRecord::Base
  belongs_to :user

  validates :date, :time, :meal, :num_of_calories, presence: true

  validates :num_of_calories, numericality: { greater_than_or_equal_to: 0 }

  # rubocop:disable Style/Lambda
  scope :with_range, ->(params) do
    scope = where(nil)
    scope = scope.where("date >= ?", params[:date_from]) if params[:date_from].present?
    scope = scope.where("date <= ?", params[:date_to]) if params[:date_to].present?
    scope = scope.where("time >= ?", params[:time_from]) if params[:time_from].present?
    scope = scope.where("time <= ?", params[:time_to]) if params[:time_to].present?
    scope
  end
  # rubocop:enable Style/Lambda
end
