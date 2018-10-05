require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #gets run before each test
  def setup
    @user = User.new(name: "Test Man", email: "test@email.com")
  end

  #tests if a valid user was created
  test "should be valid" do
    assert @user.valid?
  end


  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name length limit" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email length limit" do
    @user.name = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

end
