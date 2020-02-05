require 'rails_helper'

RSpec.describe Post, type: :model do

  context "validation tests" do
    let(:user) { create(:random_user)}
    let(:post) { build(:post, user_id: user.id)}

    it 'ensures a body is present' do
      post.body = "a" * 2
      expect(post.save).to eq(false)
      expect(post).not_to be_valid
    end

    it 'ensures a body is not too long' do
      post.body = "a" * 141
      expect(post.save).to eq(false)
      expect(post).not_to be_valid
    end
    

    it 'ensures a user_id is present' do
      post.user_id = nil
      expect(post.save).to eq(false)
      expect(post).not_to be_valid
    end

    it 'is valid with valid arguments' do
      expect(post.save).to eq(true)
      expect(post).to be_valid
    end
  end
end