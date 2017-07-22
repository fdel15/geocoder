require 'test_helper'
require 'byebug'

class AddressesControllerTest < ActionDispatch::IntegrationTest

  test "root should go to addresses#index" do
    get '/'
    assert_equal AddressesController, @controller.class
    assert_equal "index", @controller.action_name
    assert_response :success
  end

  test "submit should make post request and return text/html" do
    post '/address'
    assert_equal "create", @controller.action_name
    assert_equal "text/html", @response.content_type
    assert_redirected_to :root
  end

  test "ajax submit should make post request and return js" do
    post '/address', xhr: true
    assert_equal "create", @controller.action_name
    assert_equal "text/javascript", @response.content_type
    assert_response :success
  end
end
