require 'rails_helper'

describe User do
  it 'model should exist' do
    expect { User.count }.not_to raise_exception
  end

  it 'should have valid factory' do
    expect(Fabricate.build(:user)).to be_valid
  end

  describe 'validations should exist' do
    it 'email' do
      expect(Fabricate.build(:user, email: nil)).to_not be_valid
      expect(Fabricate.build(:user, email: '')).to_not be_valid
      expect(Fabricate.build(:user, email: '123')).to_not be_valid
    end

    it 'role' do
      expect(Fabricate.build(:user)).to enumerize(:role).in(:regular, :manager, :admin)
      expect(Fabricate.build(:user, role: nil)).to_not be_valid
      expect(Fabricate.build(:user, role: '')).to_not be_valid
      expect(Fabricate.build(:user, role: '123')).to_not be_valid
    end

    it 'role' do
      expect(Fabricate.build(:user, num_of_calories: nil)).to_not be_valid
    end
  end

  it 'should have has_many sessions' do
    expect(Session.count).to eq(0)
    user = Fabricate(:user)
    expect(user).to respond_to(:sessions)
    2.times do
      Fabricate(:session, user: user)
    end
    expect(user.sessions.count).to eq(2)
    Session.last.destroy
    expect(user.sessions.count).to eq(1)
    user.destroy
    expect(Session.count).to eq(0)
  end

end
