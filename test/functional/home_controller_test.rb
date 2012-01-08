require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get Index" do
    get :index
    assert_response :success
  end

end
