require 'test_helper'

class BorrowersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
