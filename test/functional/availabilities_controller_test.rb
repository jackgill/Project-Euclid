require 'test_helper'

class AvailabilitiesControllerTest < ActionController::TestCase
  setup do
    session[:building_id] = buildings(:timber_ridge).id
    session[:user_id] = users(:admin).id

    @availability = availabilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create availability" do
    assert_difference('Availability.count') do
      post :create, availability: @availability.attributes
    end

    assert_redirected_to availability_path(assigns(:availability))
  end

  test "should show availability" do
    get :show, id: @availability.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @availability.to_param
    assert_response :success
  end

  test "should update availability" do
    put :update, id: @availability.to_param, availability: @availability.attributes
    assert_redirected_to availability_path(assigns(:availability))
  end

  test "should destroy availability" do
    assert_difference('Availability.count', -1) do
      delete :destroy, id: @availability.to_param
    end

    assert_redirected_to availabilities_path
  end

  test "rent your own space error" do
    @availability = availabilities(:one)
    session[:user_id] = @availability.listing.lister.id
    session[:start_date] = @availability.start_date
    session[:end_date] = @availability.end_date
    
    post :rent, availability: @availability.id

    assert_redirected_to controller: :home, action: :message
  end
end
