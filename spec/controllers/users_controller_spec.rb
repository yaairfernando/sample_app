require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  let(:valid_attributes) {
    { name: "Pablo", 
      email: "pablo12@gmail.com", 
      password: "password", 
      password_confirmation: "password"}
  }

  let(:user) { FactoryBot.create(:user)}
  before(:all) do
    # @user = FactoryBot.create(:user)
  end

  describe "POST #create" do
    it 'is valid with valid attributes' do
      User.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful 
    end

    it 'is not valid with a invalid name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with a invalid email' do
      user.email = "ss"
      expect(user).not_to be_valid
    end

    it 'is not valid with a invalid password' do
      user.password = "pass"
      user.password_confirmation = "pass"
      expect(user).not_to be_valid
    end

    it 'is not valid with different password and password confirmation' do
      user.password = "passwword"
      user.password_confirmation = "passwordd"
      expect(user).not_to be_valid
    end
    
  end

  describe 'POST #Find user id when creating post' do
    let(:post) { FactoryBot.create(:post, user_id: user.id) }
    let(:my_user) { User.find post.user_id }

    it 'sets the user_id field' do
      expect(post.user_id).to eq(my_user.id)
    end
  end

  describe 'POST @Create list of users' do
    before(:all) do
      emails = ["majo@gmail.com", "sebas@gmail.com", "carlota@gmail.com"]
        emails.each do |e|
          @users = FactoryBot.create(:user, email: e )
        end
    end
    it 'return a list of users' do
      expect(@users.size).to eq(3)
    end
    
  end
  
  
  

end