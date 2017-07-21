require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @address = Address.new(query: '123 Sesame street')
  end

  test "valid address" do
    @address.valid?
  end

  test "invalid without query" do
    @address.query = nil
    refute @address.valid?, 'saved address without query'
    assert_not_nil @address.errors[:query], 'no validation error for query not present'
  end
end
