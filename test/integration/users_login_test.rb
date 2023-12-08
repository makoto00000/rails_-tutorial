require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with valid information" do
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", passowrd: "" } }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    get root_path
    assert flash.empty?
  end
end
