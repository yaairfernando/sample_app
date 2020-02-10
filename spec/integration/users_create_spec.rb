require 'rails_helper'

RSpec.describe "User Create", type: :request do
  let(:user) { create(:random_user)}
  describe "Create User" do
    it 'creates a new user after logged in' do
      log_in_as(user)
      get users_path
      expect(response.status).to eq(200)
      expect(response).to be_successful
      expect(response).to render_template('index') 
    end
  end
end