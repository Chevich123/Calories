require 'rails_helper'

RSpec.describe Session do
  it 'model should exist' do
    expect { Session.count }.not_to raise_exception
  end

  it 'should have valid factory' do
    expect(Fabricate.build(:session)).to be_valid
  end

  describe 'validations should exist' do
    it 'user' do
      expect(Fabricate.build(:session, user: nil)).to_not be_valid
    end
  end

  it 'should have belongs_to user' do
    expect(Fabricate.build(:session)).to respond_to(:user)
  end
end
