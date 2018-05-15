require 'test_helper'

class V0::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get v0_comments_show_url
    assert_response :success
  end

end
