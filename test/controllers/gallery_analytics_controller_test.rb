require 'test_helper'

class GalleryAnalyticsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get gallery_analytics_home_url
    assert_response :success
  end

end
