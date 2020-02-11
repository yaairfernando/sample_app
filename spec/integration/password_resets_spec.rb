require 'rails_helper'

RSpec.describe "Password", type: :request do
  describe 'password resets' do
    it 'resets password successfuly' do
      user = create(:user)
      get new_password_reset_path
      expect(response).to render_template('password_resets/new')
      post password_resets_path, params: { password_reset: { email: '' }}
      expect(flash[:danger]).to be_present
      assert_template 'password_resets/new'
      post password_resets_path, params: { password_reset: { email: user.email }}
      expect(user.reset_digest).not_to match(user.reload.reset_digest)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(flash).to be_present
      expect(response).to redirect_to root_path
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: "")
      expect(response).to redirect_to root_path
      user.toggle!(:activated)
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(response).to redirect_to root_path
      user.toggle!(:activated)
      get edit_password_reset_path('wrong token', email: user.email)
      expect(response).to redirect_to root_path
      get edit_password_reset_path(user.reset_token, email: user.email)
      assert_template 'password_resets/edit'
      assert_select "input[name=email][type=hidden][value=?]", user.email
      patch password_reset_path(user.reset_token),
            params: { email: user.email,
                      user: { password:              "foobaz",
                              password_confirmation: "barquux" } }
      assert_select 'div.alert-danger'
      # Empty password
      patch password_reset_path(user.reset_token),
            params: { email: user.email,
                      user: { password:              "",
                              password_confirmation: "" } }
      assert_select 'div.alert-danger'
      # Valid password & confirmation
      patch password_reset_path(user.reset_token),
            params: { email: user.email,
                      user: { password:              "foobaz",
                              password_confirmation: "foobaz" } }
      expect(is_logged_in?).to eq(true)
      expect(flash).to be_present
      expect(response).to redirect_to user
    end

    it 'expired token' do
      user = create(:user)
      get new_password_reset_path
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      user.update_attribute(:reset_sent_at, 3.hours.ago)
      patch password_reset_path(user.reset_token), params: { email: user.email,
        user: { password: "foobar", password_confirmation: "foobar" } }
      assert_response :redirect
      follow_redirect!
    end
    
  end
end