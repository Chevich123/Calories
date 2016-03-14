class Record < ActiveRecord::Base
  belongs_to :user

  validates :date, :time, :meal, :num_of_calories, presence: true

  validates :num_of_calories, numericality: { greater_than_or_equal_to: 0 }
end
