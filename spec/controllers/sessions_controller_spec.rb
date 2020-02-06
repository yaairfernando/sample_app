require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #Login' do
    it 'renders the new template' do
      get :new
      expect(response.status).to eq(200)
      expect(response).to render_template('new')
    end
  end
end