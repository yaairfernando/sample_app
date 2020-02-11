require 'rails_helper'

describe 'User SinUp', type: :request do
  let(:valid_attributes) do
    { name: 'Pablo',
      email: 'pablo12@gmail.com',
      password: 'password',
      password_confirmation: 'password' }
  end

  let(:invalid_attributes) do
    { name: '',
      email: 'user@invalid.cm',
      password: 'pas',
      password_confirmation: 'bar' }
  end

  before(:all) do
    ActionMailer::Base.deliveries.clear
  end

  describe 'POST #SignUp' do

    it 'invalid signup information' do
      get signup_path
      post users_path, params: { user: invalid_attributes }
      assert_template 'users/new'
      assert_select 'div.alert-danger'
      assert_select 'li', count: 10
    end

    it 'valid signup information with account activation' do
      get signup_path
      post users_path, params: { user: valid_attributes }
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      user = assigns(:user)
      expect(user.activated?).to eq(false)
      log_in_as(user)
      expect(is_logged_in?).to eq(false)
      get edit_account_activation_path(user.activation_token, email: 'wrong')
      expect(is_logged_in?).to eq(false)
      get edit_account_activation_path(user.activation_token, email: user.email)
      assert user.reload.activated?
      follow_redirect!
      assert_template 'users/show'
      expect(is_logged_in?).to eq(true)
    end
    

    it 'valid signup information' do
      get signup_path
      post users_path, params: { user: valid_attributes }
      follow_redirect!
      # assert_template 'users/show'
      # assert is_logged_in?
    end
  end
end
