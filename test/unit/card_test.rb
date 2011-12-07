require 'test_helper'

class CardTest < ActiveSupport::TestCase
   
   #initilisation tests
   test "Card string must be same as string argument" do
     cards = Card.all_cards               
     cards.each do |cstr|
       c = Card.new(cstr)
       assert_equal cstr , c.str
     end
   end

  #must raise error if string is invalud 
  test "Card must raise error if string is invalid" do
    assert_raise RuntimeError do 
      c = Card.new ('&*')
    end
  end 
  
  #test same suit 
  test "Test card same suit" do
    c1 = Card.new('7C')
    c2 = Card.new('8C')
    c3 = Card.new('8H')
    assert_equal true, c1.same_suit?(c2)
    assert_equal false, c1.same_suit?(c3)
  end 

  #test same id
  test "Card is equal with same value" do
    cards = Card.all_cards
    cards.each do |str|
      c1 = Card.new(str)
      c2 = Card.new(c1.str) 
      assert_equal true, c1 == c2
    end 
  end
  
  #copare value 
  # 7S < 8H , TH > 9C
  test "Compare value ... smaller and bigger " do
    c1 = Card.new('7S')
    c2 = Card.new('8H')
    c3 = Card.new('TH')
    
    assert_equal true, c2.biger_then(c1)
    assert_equal true, c3.biger_then(c2)
    assert_equal false, c2.biger_then(c3)
    assert_equal false, c2.biger_then(c2)

    assert_equal false, c2.smaller_then(c1)
    assert_equal false, c3.smaller_then(c2)
    assert_equal true,  c2.smaller_then(c3)
    assert_equal false, c2.smaller_then(c2)

  end 

end
