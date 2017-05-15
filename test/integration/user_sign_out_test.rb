require 'test_helper'

class UserSignOutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:dom)
  end

  test "sign in and sign out with valid information" do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, params: { session: { email: "#{@user.email}",
                                password: "password1"}}
                                assert_redirected_to user_path @user
                                follow_redirect!
                                assert_equal true, is_logged_in?
                                assert_template 'users/show'
                                assert_select "a[href=?]", signin_path, count: 0
                                assert_select "a[href=?]", signout_path
                                assert_select "a[href=?]", user_path(@user)
    delete signout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_not is_logged_in?
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', signup_path, count: 1
    assert_select "a[href=?]", signout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
