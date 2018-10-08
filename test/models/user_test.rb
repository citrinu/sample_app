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

  test "accept valid emails"  do
    #creates an array of valid emails
    valid_emails = %w[thisworks@example.com yep@mail.COM forest@green.mail.com]

    #iterates through the array
    valid_emails.each do |valid_email|
      @user.email = valid_email #sets email to passed in one
      assert @user.valid?, "#{valid_email.inspect} should be a valid email." #optional arg provides an error message
    end
  end

  test "reject invalid emails" do
    invalid_email = %w[heyhey@email,com wont.work@w@email.com meme@meme+meme.com]

    invalid_email.each do |invalid_emails|
      @user.email = invalid_emails
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end

  test "emails should be unique" do
    duplicate_user = @user.dup #creates a user
    duplicate_user.email = @user.email.upcase # for case sensivity
    @user.save #saves it to the db
    assert_not duplicate_user.valid?
  end



end
