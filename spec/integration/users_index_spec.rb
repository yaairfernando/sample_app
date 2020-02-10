require 'rails_helper'

RSpec.describe "Users #Index", type: :request do
  let(:user) { create(:random_user)}
  let(:another_user) {create(:random_user)}
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

    it 'index as admin including pagination and delete links' do
      users = create_list(:random_user, 40)
      user.toggle!(:admin)
      log_in_as(user)
      get users_path
      expect(response).to render_template('users/index')
      assert_select 'div.pagination', count: 2
      first_page_of_users = User.paginate(page: 1)
      first_page_of_users.each do |user|
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == user
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      end
      expect do
        delete user_path(user)
      end.to change{ User.count(-1)}
    end

    it 'index as non-admin' do
      log_in_as(another_user)
      get users_path
      assert_select 'a', text: 'delete', count: 0
    end
  end
end