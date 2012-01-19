require 'test_helper'

class BidTest < ActiveSupport::TestCase
  
  #new bid
  def setup 
    @b = Bid.new
    @first_bid_2 = Bid.new
    @first_bid_2.bid('NB')
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
    assert_equal false, @first_bid_2.is_end?
    @first_bid_2.bid('P')
    @first_bid_2.bid('P')
    assert_equal false, @first_bid_2.is_end?
  end 

 test "game bid" do
   @b.bid("G")
   assert_raise RuntimeError do
     @b.bid("NB")
    end
 end
 
 test "can't bid everything" do
   assert_equal false, @b.bid_posible?('BRACA')  
   assert_equal false, @first_bid_2.bid_posible?('BRACA')  
 end
 
 test "In any time can pass" do
   assert_equal true, @b.bid_posible?('P')
   assert_equal true, @first_bid_2.bid_posible?('P')
 end
 
 test "When we can make NB " do
   assert_equal true, @b.bid_posible?("NB")
   @b.bid("G")
   assert_equal false, @b.bid_posible?("NB")
 end   
 
 test "When we can call a game" do
   assert_equal true, @b.bid_posible?("G")
   assert_equal true, @b.bid_posible?("GB")
   assert_equal true, @b.bid_posible?("GS")
   @b.bid("GB")
   assert_equal false, @b.bid_posible?("G")
   assert_equal true, @b.bid_posible?("GS")
 end

 test "posible bids" do
   a = @b.posible_bids
   puts a
   #must be pass,next_bid,game,bettle game, sans_game
   assert_equal true, a.include?('P')
   assert_equal true, a.include?('NB')
   assert_equal true, a.include?('G')
   assert_equal true, a.include?('GS')
   assert_equal true, a.include?('GB')
   assert_equal 5, a.size 
 end
  
end
