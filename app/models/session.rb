class Session < ActiveRecord::Base
  belongs_to :user
  validates :user, :authorization_token, presence: true

  before_validation :set_authorization_token, on: :create

  private
  def set_authorization_token
    self.authorization_token = SecureRandom.hex(32)
  end

end
