require 'rails_helper'

RSpec.describe "User Edit", type: :request do

  let(:invalid_attributes) do
    {
      name: "Ya",
      email: "ya@com",
      password: "pass",
      password_confirmation: "pass"
    }
  end

  let(:valid_attributes) do
    {
      name: "John",
      email: "john@gmail.com",
      password: "",
      password_confirmation: ""
    }
  end

  describe "#PATCH" do
    it 'unsuccessful edit' do
      user = create(:random_user)
      get edit_user_path(user)
      expect(response).to render_template('users/edit')
      patch user_path(user), params: { user: invalid_attributes }
      expect(response).to render_template('users/edit')
      assert_select 'div.alert', 1
      assert_select 'li', 8
    end

    it 'successful edit' do
      user = create(:random_user)
      name = valid_attributes[:name]
      get edit_user_path(user)
      expect(response).to render_template('users/edit')
      patch user_path(user), params: { user: valid_attributes }
      user.reload
      expect(response).to redirect_to(user_path(user))
      expect(flash[:success]).to be_present
      expect(name).to match(user.name)
    end
    
    
  end
  

end