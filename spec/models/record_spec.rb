require 'rails_helper'

describe Record do
  it 'model should exist' do
    expect { Record.count }.not_to raise_exception
  end

  it 'should have valid factory' do
    expect(Fabricate.build(:record)).to be_valid
  end

  describe 'validations' do
    it 'meal' do
      expect(Fabricate.build(:record, meal: nil)).not_to be_valid
    end
    it 'date' do
      expect(Fabricate.build(:record, date: nil)).not_to be_valid
    end
    it 'time' do
      expect(Fabricate.build(:record, time: nil)).not_to be_valid
    end
    it 'num_of_calories' do
      expect(Fabricate.build(:record, num_of_calories: nil)).not_to be_valid
      expect(Fabricate.build(:record, num_of_calories: -1)).not_to be_valid
      expect(Fabricate.build(:record, num_of_calories: 0)).to be_valid
    end
  end
end
