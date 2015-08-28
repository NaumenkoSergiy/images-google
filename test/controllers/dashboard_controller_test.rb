require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get index" do
    sign_in users(:one)

    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
  end
end
