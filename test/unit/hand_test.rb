require 'test_helper'

class HandTest < ActiveSupport::TestCase
  # test creation of hand
  test "create hand" do 
    hand = Hand.new
    hand.create  
    #must me string
    assert_equal "123".class, hand.cards.class 
    #must be 32*2 long
    assert_equal 32*2, hand.cards.size
  end

  # testing creation of Array from cards string  
  test "get cards" do 
    hand = Hand.new
    hand.create
    a = hand.get_cards
    assert_equal Card,a[0].class
    assert_equal 32, a.size
  end 

end
