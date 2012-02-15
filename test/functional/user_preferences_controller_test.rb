require 'test_helper'

class UserPreferencesControllerTest < ActionController::TestCase
  setup do
    session[:building_id] = buildings(:timber_ridge).id
    session[:user_id] = users(:bob).id
    @user = users(:bob)
    @user_preference = user_preferences(:one)
  end
  
  test "should get show" do
    get :show, id: @user_preference.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_preference.to_param
    assert_response :success
  end

  test "should update user preference" do
    put :update, id: @user_preference.to_param, user_preference: @user_preference.attributes
    assert_redirected_to user_preference_path(assigns(:user_preference))
  end

end
