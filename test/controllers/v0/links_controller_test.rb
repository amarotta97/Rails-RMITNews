require 'test_helper'

class V0::LinksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get v0_links_show_url
    assert_response :success
  end

end
