require 'test_helper'

class HandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # test creation of hand
  test "create hand" do 
    hand = Hand.new
    hand.create  
    #must me string
    assert_equal "123".class, hand.cards.class 
    #must be 32*2 long
    assert_equal 32*2, hand.cards.size
  end
end
