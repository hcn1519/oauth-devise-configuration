require 'test_helper'

class VisitorControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get visitor_main_url
    assert_response :success
  end

end
