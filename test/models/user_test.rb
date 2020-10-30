require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
    assert 1==1, "1 is equivalent to 1"
    #assert 2==1, "2 is not equivalent to 1, assert"
    assert_not 2==1, "2 is not equivalent to 1, assert_not"
  end

  test "compare users1" do
    #user1= User.all.first
    user2= User.find_by(id: 3)

    #user3= User.find(3)
    user3= User.find_by(id: 3)
    #user2= User.find(1)
    assert_equal(user3, user2, "SAME USER!")
  end

  test "compare users2" do
    #user1= User.all.first
    user2= User.find_by(id: 3)

    user3= User.find_by(id: 3)
    #user2= User.find(1)
    assert_same(user3, user2, "SAME USER!")
  end

  test "check nil" do
    user= User.new

    user2= nil
    assert_nil( user2, "object is nil!")
  end


  test "check empty" do
    user= User.new
    user2=""
    assert_empty( user2, "object is empty!")
  end

  test "match regex" do
    string = "neko@animal.com"
    #string = "neko@animalcom"

    assert_match(/^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/, string, "matching regex")
  end

  test "same type" do
    #user = User.new
    user= User.all.first
    assert_includes(User.all, user,"same type")
  end



  test "should not save user without title" do
    user = User.new
    assert_not user.save, "Saved the user without name"
  end
  test "should report error1" do
    # some_undefined_variableはテストケースのどこにも定義されていない
    #some_undefined_variable
    assert true
  end
  test "should report error2" do
    # some_undefined_variableはテストケースのどこにも定義されていない
    assert_raises(NameError) do
      some_undefined_variable
    end
  end



  test "mentioned error happened" do
    user= User.all.first
    assert_raises(TypeError) do
      user.add(2,"0")
    end
  end


end
