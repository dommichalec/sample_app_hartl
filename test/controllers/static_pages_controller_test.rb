require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  # return a 200 when the root url is received and assert title is correct
  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "#{$SITE_TITLE}"
  end

  # return a 200 when the help url is received and assert title is correct
  test "should get help" do
    get help_url
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
  end

  # return a 200 when the about url is received and assert title is correct
  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App"
  end

  # return a 200 when the contact url is received and assert title is correct 
  test "should get contact" do
    get contact_url
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end

end
