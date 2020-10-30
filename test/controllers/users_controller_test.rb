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

  test "routes check" do
    assert_routing({ method: 'get', path: 'users/new' }, controller: 'users', action: 'new')
    assert_routing({ method: 'post', path: 'users' }, controller: 'users', action: 'create')
    assert_routing({ method: 'get', path: 'meals/search' }, controller: 'meals', action: 'search')
    assert_routing({ method: 'patch', path: 'meals/1' }, controller: 'meals', action: 'update', id: '1')
  end

  test "recognize" do
    #assert_recognizes({controller: 'users', action: 'update', id: '1', view: 'users/1' },
    assert_recognizes({controller: 'users', action: 'update', id: '1' },
                      {path: 'users/1', method: :put, view: 'users/1' })
  end
end
