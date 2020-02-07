require 'rails_helper'

RSpec.describe SessionsHelper do
  it 'current_user returns right user when session is nil' do
    @user = create(:random_user)
    remember(@user)
    assert_equal @user, current_user
    assert is_logged_in?
  end

  it 'current_user returns nil when remember digest is wrong' do
    @user = create(:random_user)
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
  
  
end
