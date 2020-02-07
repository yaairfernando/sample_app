require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views
  let(:title) { 'Ruby on Rails Tutorial Sample App' }

  describe 'GET #home' do
    it 'return a 200 status code' do
      get :home
      expect(response).to render_template('home')
      expect(response.status).to eq(200)
      expect(response).to have_http_status(200)
      expect(response.body).to have_title(@title.to_s)
    end
  end

  describe 'GET #help' do
    it 'return a 200 status code' do
      get :help
      expect(response).to render_template('help')
      expect(response.status).to eq(200)
      expect(response.body).to have_title(@title.to_s)
    end
  end

  describe 'GET #about' do
    it 'return a 200 status code' do
      get :about
      expect(response).to render_template('about')
      expect(response.status).to eq(200)
      expect(response.body).to have_title(@title.to_s)
    end
  end

  describe 'GET #contact' do
    it 'return a 200 status code' do
      get :contact
      expect(response).to render_template('contact')
      expect(response.status).to eq(200)
      expect(response.body).to have_title(@title.to_s)
    end
  end
end
