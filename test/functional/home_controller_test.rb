require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    session[:building_id] = buildings(:timber_ridge).id
    session[:user_id] = users(:bob).id
    @user = users(:bob)
  end
  
  test "should get Index" do
    get :index
    assert_response :success
  end

end
