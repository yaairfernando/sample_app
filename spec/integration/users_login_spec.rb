require 'rails_helper'

describe 'User Login', type: :request do
  describe 'POST #Login' do
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
  end

end