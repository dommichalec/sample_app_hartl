# rails g integration_test site_layout
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template '/'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
  end

  test "full title helper" do
    # include ApplicationHelper for accessing full_title method
    get contact_path
    assert_select "title", full_title("Contact")
    get help_path
    assert_select "title", full_title("Help")
    get about_path
    assert_select "title", full_title("About")
    get signup_path
    assert_select "title", full_title("Sign up")
  end
end

# use  rails test test/integration/site_layout_test.rb to run these tests and
# only these tests
