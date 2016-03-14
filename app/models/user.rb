class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :validatable

  has_many :sessions, dependent: :delete_all

  extend Enumerize
  enumerize :role, in: %w(regular manager admin), predicates: true

  validates :email, presence: true, email: true,  uniqueness: true
  validates :role, presence: true
  validates :num_of_calories, numericality: {greater_than_or_equal_to: 0}


end
