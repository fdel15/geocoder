require 'test_helper'
require 'byebug'

class AddressesControllerTest < ActionDispatch::IntegrationTest

  test "root should go to addresses#index" do
    get '/'
    assert_equal AddressesController, @controller.class
    assert_equal "index", @controller.action_name
    assert_response :success
  end
end
