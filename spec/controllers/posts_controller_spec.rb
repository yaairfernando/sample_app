require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

  let(:user_valid_attributes) {
    { name: "Pablo", 
      email: "pablo12@gmail.com", 
      password: "password", 
      password_confirmation: "password"}
  }

  before(:all) do
    
  end

  describe "Get index" do
    it 'has a 200 status code' do
      get :index
      expect(response).to render_template('index') 
      expect(response.status).to eq(200) 
    end


    it 'returns a success response' do
      u = User.create! user_valid_attributes
      post :create, :params => { :post => { :buuu => "Post body", :user_id => u.id }}
      get :index, params: {}
      expect(response).to be_successful 
    end
    
    
  end

  describe "Get New" do
    it 'has a 200 status code' do
      get :new
      expect(response).to render_template('new')
      expect(response.status).to eq(200) 
    end
  end

  describe "should create post" do
    it 'has a 200 status code' do
      post :create, :params => { :post => { :body => "This is a post"}}
      expect(response.content_type).to eq "text/html" 
    end
  end

  describe 'GET /post/:id', action_name: 'Get a post' do
    let(:user) { FactoryBot.create :user }
    let(:post) { FactoryBot.create(:post, user_id: user.id) }
    it 'gets a post' do
      # get edit_post_path(post)
      # expect(response).to have_http_status(200)
    end
  end  
end