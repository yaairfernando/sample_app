require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    { name: "Pablo", 
      email: "pablo12@gmail.com", 
      password: "password", 
      password_confirmation: "password"}
  }

  describe "POST #create" do
    it 'returns a success response after creating the User' do
      User.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful 
    end
    
  end
  

end