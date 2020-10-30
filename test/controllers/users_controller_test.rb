require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_path
    #assert_response :success
    #assert_redirected_to path
    assert_redirected_to login_path
  end

  test "should get index2" do
    get users_path
    #logined user should be routed here though...
    assert_redirected_to meals_path
  end

end
