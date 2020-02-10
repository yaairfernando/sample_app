require 'rails_helper'

RSpec.describe "Users #Index", type: :request do
  let(:user) { create(:random_user)}
  describe "#Index" do
    it "index including pagination" do
      users = create_list(:random_user, 40)
      log_in_as(user)
      get users_path
      expect(response).to render_template('users/index')
      assert_select 'div.pagination', count: 2
      User.paginate(page: 1).each do |user|
        assert_select 'a[href=?]', user_path(user), text: user.name
      end
    end
  end
  

end