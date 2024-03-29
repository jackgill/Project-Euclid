require 'test_helper'

class AccountControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :redirect
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
