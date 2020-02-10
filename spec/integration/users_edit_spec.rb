require 'rails_helper'

RSpec.describe "User Edit", type: :request do

  let(:invalid_attributes) do
    {
      name: "Ya",
      email: "ya@com",
      password: "pass",
      password_confirmation: "pass"
    }
  end

  let(:valid_attributes) do
    {
      name: "John",
      email: "john@gmail.com",
      password: "",
      password_confirmation: ""
    }
  end

  let(:another_user) { create(:random_user)}
  let(:user) { create(:user)}

  describe "#PATCH" do
    it 'unsuccessful edit' do
      user = create(:random_user)
      log_in_as(user)
      get edit_user_path(user)
      expect(response).to render_template('users/edit')
      patch user_path(user), params: { user: invalid_attributes }
      expect(response).to render_template('users/edit')
      assert_select 'div.alert', 1
      assert_select 'li', 13
    end

    it 'successful edit' do
      user = create(:random_user)
      log_in_as(user)
      name = valid_attributes[:name]
      get edit_user_path(user)
      expect(response).to render_template('users/edit')
      patch user_path(user), params: { user: valid_attributes }
      user.reload
      expect(response).to redirect_to(user_path(user))
      expect(flash[:success]).to be_present
      expect(name).to match(user.name)
    end

    it 'should redirect edit when logged in as wrong user' do
      log_in_as(another_user)
      get edit_user_path(user)
      expect(flash[:danger]).to be_present
      expect(response).to redirect_to root_path
    end

    it 'should redirect update when logged in as wrong user' do
      log_in_as(another_user)
      patch user_path(user), params: { user: valid_attributes }
      expect(flash[:danger]).to be_present
      expect(response).to redirect_to root_path
    end

    it 'successful edit with friendly forwarding' do
      get edit_user_path(user)
      log_in_as(user)
      expect(response).to redirect_to edit_user_path(user)
      patch user_path(user), params: { user: valid_attributes }
      expect(flash[:danger]).to be_present
      expect(response).to redirect_to user
      user.reload
      expect(valid_attributes[:name]).to match(user.name)
      expect(valid_attributes[:email]).to match(user.email)
    end
    
  end
end