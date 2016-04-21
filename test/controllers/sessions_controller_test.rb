require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
  test "should get login page" do
    get :new
    assert_response :success
    assert_select "title", "Log in | #{@base_title}"
  end
end
