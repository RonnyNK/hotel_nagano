require 'test_helper'

class ReservedRoomsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
