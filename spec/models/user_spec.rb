require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
    let(:user) { build(:random_user) }
    let(:users) { create_list(:random_user, 5 )}
    it 'ensures name presence' do
      user.name = nil
      expect(user.save).to eq(false)
      expect(user).not_to be_valid  
    end

    it 'ensures email presence' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.save).to eq(false)
    end

    it 'ensures password presence' do
      user.password = nil
      expect(user).not_to be_valid
      expect(user.save).to eq(false)
    end

    it 'ensures password_confirmation presence' do
      user.password = nil
      user.password_confirmation = nil
      expect(user).not_to be_valid
      expect(user.save).to eq(false)
    end

    it 'is valid with valid attributes' do
      expect(user.save).to eq(true) 
      expect(user).to be_valid
    end

    it 'returns an array of all users' do
      expect(users.size).to eq(5)
    end

    it 'return the first and last user' do
      expect(users.last.id).to eq(5)
      expect(users.first.id).to eq(1)
    end
  end
end