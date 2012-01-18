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

    @b.bid('NB')
    assert_equal 7, @b.bids.size
    assert_equal 'm4', @b.last_bid

  end
  
  test "check end" do
    @b.bid("P")
    @b.bid("P")
    @b.bid("P")
    assert_equal true, @b.is_end?
  end 

 test "game bid" do
   @b.bid("G")
   assert_raise RuntimeError do
     @b.bid("NB")
    end
 end
 
 test "can't bid everything do" do
   assert_equal false, @b.bid_posible?('BRACA')  
 end
 
 test "In any time can pass" do
   assert_equal true, @b.bid_posible?('P')
 end
 
 test "Can't double when no one bid" do
   assert_equal false , @b.bid_posible?('D') 
 end
 
 test "Can't redouble when no no one bid" do
   assert_equal false, @b.bid_posible?('RD')
 end
  
 test "is bid possible?" do



#   assert_equal false , @b.bid_posible?('RD')
#   assert_equal true, @b.bid_posible?('NB')
#   assert_equal true, @b.bid_posible?('G')

#   assert_equal true, @b.bid_posible?('GB') 
#   assert_equal true, @b.bid_posible?('GS') 
 end 

 test "posible bids" do
   a = @b.posible_bids
   #must be pass,next_bid,game,bettle game, sans_game
   assert_equal true, a.include?('P')

#   assert_equal true, a.include?('NB')
#   assert_equal true, a.include?('G')
#   assert_equal true, a.include?('GB')
#   assert_equal true, a.include?('GS')

#  assert_equal false, a.include?(['D','RD'])
 end
  
end
