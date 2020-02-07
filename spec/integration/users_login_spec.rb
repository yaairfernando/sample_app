require 'rails_helper'

describe 'User Login', type: :request do
  
  describe 'POST #Login' do
    # fixtures :users
    it 'login with invalid information' do
      get login_path
      expect(response.status).to eq(200)
      expect(response).to render_template('new')
      post login_path, params: { session: { email: "", password: ""}}
      expect(response).to render_template('new')
      expect(flash[:danger]).to be_present
      get root_path
      expect(flash[:danger]).not_to be_present
    end

    it 'login with valid information' do
      user = create(:user_login, email: "yair.facio11@gmail.com", password: "password")
      get login_path
      post login_path, params: { session: { email: user.email, password: 'password'}}
      expect(response).to redirect_to :action => :show, :controller => :users, :id => user.id
      assert_redirected_to user
      follow_redirect!
      assert_template 'users/show'
      assert_select "a[href=?]", login_path, count: 0
      assert_select "a[href=?]", logout_path
      assert_select "a[href=?]", user_path(user)
    end
    
  end

end