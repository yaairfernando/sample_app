require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user_valid_attributes) do
    { name: 'Pablo',
      email: 'pablo12@gmail.com',
      password: 'password',
      password_confirmation: 'password' }
  end
  let(:user) { FactoryBot.create(:random_user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }

  describe 'Get index' do
    it 'has a 200 status code' do
      get :index
      expect(response).to render_template('index')
      expect(response.status).to eq(200)
    end
  end

  describe 'Get New' do
    it 'has a 200 status code' do
      get :new
      expect(response).to render_template('new')
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #Create' do
    it 'is valid with valid attributes' do
      u = User.create! user_valid_attributes
      create(:post, user_id: u.id)
      get :index, params: {}
      expect(response.content_type).to eq 'text/html'
      expect(response).to be_successful
    end

    it 'is not valid with an invalid body' do
      post.body = nil
      expect(post).not_to be_valid
      expect(post.errors.any?).to eq(true)
      expect(response.status).to eq(200)
    end

    it 'is not valid with an invalid user_id' do
      post.user_id = 12_000
      expect(post).not_to be_valid
      expect(post.errors.any?).to eq(true)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #Show' do
    it 'returns with a 200 status code' do
      get :show, params: { id: post.id }
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'PUT #Edit' do
    it 'updates a post' do
      new_attributes = { body: 'This is the new body' }
      user = create(:random_user)
      post = create(:random_post, user_id: user.id)
      put :update, params: { id: post.id, post: new_attributes }
      post.reload
      expect(assigns(:post).attributes['body']).to match(new_attributes[:body])
      expect(assigns[:post]).not_to be_new_record
    end
  end

  describe 'DELETE #Destroy' do
    it 'delete a post' do
      user = create(:random_user)
      post = create(:post, user_id: user.id)
      delete :destroy, params: { id: post.id }
      expect(flash[:notice]).to be_present
    end
  end
end
