require 'test_helper'

class MealTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get assignment" do
    get meal_types_assignment_url
    assert_response :success
  end

end
