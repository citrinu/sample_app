require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  #gets a count of the Users
  #tries to make an invalid user
  #checks to see if the count is the user
  test "invalid signup info" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: {name: "", email: "user@none",password: "test", password_confirmation: "test1"}}
    end

    assert_template 'users/new'

    #checks for error messages
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup info" do
    get signup_path #gets sign up url
    assert_difference 'User.count', 1 do #checks for 1 additional user
      #checks a post with the correct params was made
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
      follow_redirect! # checks for a redirect
      assert_template 'users/show' #checks that it renders using the show action
      assert_not flash.empty?
      assert is_logged_in?
  end

end
