require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  before(:all) do
    session[:code] = ENV['CODE']
    session[:token] = AuthHeader
  end

  test 'should get index' do
    sign_in users(:one)

    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test 'albums should be empty for non-authorized user' do
    get :index
    assert_response :success
    assert_nil assigns(:albums)
  end
end
