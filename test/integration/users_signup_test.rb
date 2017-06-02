# rails g integration_test users_signup
require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "submitting invalid data should not create a user" do
    get signup_path
    # submitting this data should not increase the User.count by one
    assert_no_difference 'User.count' do
           post users_path, params: { user: { first_name:  "      ",
                                              last_name: "      ",
                                              email: "user@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    end
    # make sure to render new.html.erb after a failed submission
    assert_template 'users/new'
  end

  test "submitting valid data should create a new user" do
    get signup_path
    # submitting this data should increase the User.count by one
    assert_difference 'User.count', 1 do
            post users_path, params: { user: { first_name:  "Alan",
                                              last_name: "Hamwi",
                                              email: "alan@sample.com",
                                              password:              "password",
                                              password_confirmation: "password" } }
    end
    assert_equal true, is_logged_in?
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end

# use  rails test test/integration/users_signup_test.rb to run these tests and
# only these tests
