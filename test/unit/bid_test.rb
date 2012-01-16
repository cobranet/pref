require 'test_helper'

class BidTest < ActiveSupport::TestCase
  test "initialize bid" do
    bid = Bid.new(nil,'NB')
    assert_equal 'NB', bid.bid
    assert_raise RuntimeError do
      bid1 = Bid.new(nil,'something')
    end
  end
end
