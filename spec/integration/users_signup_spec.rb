require 'rails_helper'

describe 'User SinUp', type: :request do
  let(:valid_attributes) do
    { name: 'Pablo',
      email: 'pablo12@gmail.com',
      password: 'password',
      password_confirmation: 'password' }
  end
  describe 'POST #SignUp' do
    it 'valid signup information' do
      get signup_path
      post users_path, params: { user: valid_attributes }
      follow_redirect!
      assert_template 'users/show'
      assert is_logged_in?
    end
  end
end
