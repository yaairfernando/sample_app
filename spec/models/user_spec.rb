require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
    let(:user) { build(:user) }
    it 'ensures name presence' do
      user.name = nil
      expect(user.save).to eq(false) 
    end

    it 'ensures email presence' do
      user.email = nil
      expect(user.save).to eq(false) 
    end

    it 'ensures password presence' do
      user.password = nil
      expect(user.save).to eq(false)
    end

    it 'ensures password_confirmation presence' do
      user.password_confirmation = nil
      expect(user.save).to eql(false)
    end
  end
  


end