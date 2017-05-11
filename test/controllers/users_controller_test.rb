require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(first_name: "Dominic", last_name: "Michalec",
                     email: "dom@sample.com", password: "password1",
                     password_confirmation: "password1")
  end
  # return a 200 when the help url is received and assert title is correct
  test "should get signup" do
    get signup_url
    assert_response :success
    assert_select "title", "Sign up | Ruby on Rails Tutorial Sample App"
  end
end
