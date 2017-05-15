# rails g integration_test user_signin
require 'test_helper'

class UserSigninTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:dom)
  end

  test "signin with invalid information" do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, params: { session: { email: "", password: "" } }
    assert_equal false, is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "sigin with valid information" do
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
  end
end

# use  rails test test/integration/users_login_test.rb to run this test and
# only this test
