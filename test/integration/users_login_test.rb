require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "invalid login" do
    #goto the login url
    get login_path
    #check it renders, controller/action
    assert_template 'sessions/new'
    #test post of login with a bad login
    post login_path, params: {session: { email: "", password: ""}}
    #page shouldnt change
    assert_template 'sessions/new'
    #check for error message
    assert_not flash.empty?

    #check that flash message doesnt carry over
    get root_path
    assert flash.empty?
  end

  test "login with valid info then logout" do
    get login_path
    post login_path, params: {session: { email: @user.email, password: 'password'}}
    assert is_logged_in?
    #did we goto the user page?
    assert_redirected_to @user #target user page
    follow_redirect! #goto the user page

    #call user action
    assert_template 'users/show'
    #check page for a login url, should be 0 links
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    #logout
    delete logout_path #crud on logout
    assert_not is_logged_in?
    assert_redirected_to root_url #go home
    follow_redirect!

    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end





end
