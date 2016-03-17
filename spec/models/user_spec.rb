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

    it 'num_of_calories' do
      expect(Fabricate.build(:user, num_of_calories: nil)).to_not be_valid
      expect(Fabricate.build(:user, num_of_calories: -1)).to_not be_valid
      expect(Fabricate.build(:user, num_of_calories: 0)).to be_valid
    end

    it 'password' do
      expect(Fabricate.build(:user, password: nil, password_confirmation: nil)).to_not be_valid
      expect(Fabricate.build(:user, password: '456', password_confirmation: '456')).to_not be_valid
      expect(Fabricate.build(:user, password: '456456456', password_confirmation: '123123123')).not_to be_valid
      expect(Fabricate.build(:user, password: '456456456', password_confirmation: nil)).not_to be_valid
      expect(Fabricate.build(:user, password: '456456456', password_confirmation: '456456456')).to be_valid
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

  it 'should have has_many records' do
    expect(Record.count).to eq(0)
    user = Fabricate(:user)
    expect(user).to respond_to(:records)
    2.times do
      Fabricate(:record, user: user)
    end
    expect(user.records.count).to eq(2)
    Record.last.destroy
    expect(user.records.count).to eq(1)
    user.destroy
    expect(Record.count).to eq(0)
  end
end
