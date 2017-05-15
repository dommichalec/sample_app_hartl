require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signin_path
    assert_response :success
    assert_select "title", "Sign in | Ruby on Rails Tutorial Sample App"
  end
end
