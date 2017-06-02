# to test this particular test only run rails test test/models/user_test.rb

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # set up an initial valid user as an instance variable @user to
  # be used throughout the tests
  def setup
    @user = users(:connie)
  end

  # first_name tests

  # a user should always have a first_name
  test "first name should be present" do
    @user.first_name = "      "
    assert_not @user.valid? # returns true if passes, false if fails
  end

  # a users's first name should not be longer than 30 characters
  test "first name should not be too long" do
    @user.first_name = "x"*31
    assert_not @user.valid?
  end

  # last_name tests

  # a user should always have a last_name
  test "last name should be present" do
    @user.last_name = "      "
    assert_not @user.valid? # returns true if passes, false if fails
  end

  # a users's last name should not be longer than 30 characters
  test "last name should not be too long" do
    @user.last_name = "x"*31
    assert_not @user.valid?
  end

  # email tests

  # a user should always have an email
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  # a user's email should not be longer than a string allows (255 characters)
  test "email should not be too long" do
    @user.email = "x"*244 + "@example.com"
    assert_not @user.valid?
  end

  # a valid email address should be saved to the database
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # an invalid email address should not be saved to the database
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com, foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # an email address record should be unique
  test "email should be unique" do
    user = @user.dup # creates a duplicate user with the same attributes
    @user.save
    assert_not user.valid?
  end

  # an email address record should be downcased before save
  test "email should be downcase" do
    @user.email = "DOM@EXAMPLE.COM" # creates a duplicate user with the same attributes
    @user.save
    assert_equal "dom@example.com", @user.reload.email
  end

  # password tests

  # ensure a password is present
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = "      " * 6
    assert_not @user.valid?
  end

  # ensure the password is long enough
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  # ensure the password and password confirmation are the same
  test "password and password confirmation are the same" do
    @user.password = "password"
    @user.password_confirmation = "password1"
    @user.save
    assert_not @user.valid?
  end

  # ensure user is not authenticated
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  # tests the dependent: :destroy relationship between user and micropost
  test "associated microposts should be destroyed" do
    @user.save!
    @micropost = @user.microposts.create(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
