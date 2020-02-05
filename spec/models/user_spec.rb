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

    it 'ensures name is not too long' do
      user.name = "a" * 51
      expect(user).not_to be_valid
      expect(user.save).to eq(false)
    end

    it 'ensures email presence' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.save).to eq(false)
    end

    it 'ensures email is not too long' do
      user.email = "a" * 244 + "@example.com"
      expect(user).not_to be_valid
      expect(user.save).to eq(false)
    end
    

    it 'ensures email has a valid address' do
      valid_address = %w[user@example.com USER@foo.COM 
        A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_address.each do |valid|
        user.email = valid
        expect(user).to be_valid
        expect(user.save).to eq(true)
      end
    end

    it 'ensures validation should reject invalid addresses' do
      invalid_addresses = %w[user@exampl,com user_at_foo.org
        user.name@example. foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid|
        user.email = invalid
        expect(user).not_to be_valid
        expect(user.save).to eq(false)
      end
    end

    it 'ensures email is unique' do
      user = create(:user)
      expect(build(:user).save).to eq(false)
      expect(build(:user)).not_to be_valid
    end
    
    it 'ensures email is saved as lower case' do
      mixed_email = "Foo@ExaMPle.cOm"
      user.email = mixed_email
      user.save
      expect(mixed_email.downcase).to eq(user.reload.email)
    end
    
    it 'ensures password presence' do
      user.password = nil
      expect(user).not_to be_valid
      expect(user.save).to eq(false)
    end

    it 'ensures password have a minimum length' do
      user.password = user.password_confirmation = "a" * 5
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