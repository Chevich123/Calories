class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :validatable

  has_many :sessions, dependent: :delete_all
  has_many :records, dependent: :delete_all

  extend Enumerize
  enumerize :role, in: %w(regular manager admin), predicates: true

  validates :role, presence: true
  validates :password_confirmation, presence: { if: :new_record? }
  validates :num_of_calories, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2_147_483_647 }
end
