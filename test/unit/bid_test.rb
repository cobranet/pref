require 'test_helper'

class BidTest < ActiveSupport::TestCase
  #new bid
  def setup 
    @b = Bid.new
  end
  test "initialize bid" do
    b = Bid.new
    assert_equal Array, b.bids.class
    assert_equal 0, b.bids.size
  end
  
  test "bidding NB and P" do
    @b.bid('NB')
    assert_equal 1, @b.bids.size
    assert_equal '2', @b.last_bid
    
    @b.bid('P')
    assert_equal 2, @b.bids.size
    assert_equal '2', @b.last_bid   

    @b.bid('NB')
    assert_equal 3, @b.bids.size
    assert_equal '3', @b.last_bid
    
    @b.bid('NB')
    assert_equal 4, @b.bids.size
    assert_equal 'm3', @b.last_bid

    @b.bid('NB')
    assert_equal 5, @b.bids.size
    assert_equal '4', @b.last_bid

    @b.bid('P')
    assert_equal 6, @b.bids.size
    assert_equal '4', @b.last_bid
  end

   
 
  
end
