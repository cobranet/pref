require 'test_helper'

class CardTest < ActiveSupport::TestCase
   
   #initilisation tests
   test "Card string must be same as string argument" do
     cards = Card.all_cards               
     cards.each do |card|
       c =  Card.new(card.str)
       assert_equal card.str, c.str
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
    cards.each do |card|
      c2 = Card.new(card.str) 
      assert_equal true, card == c2
    end 
  end
  
  #copare value 
  # 7S < 8H , TH > 9C
  test "Compare cards " do
    c1 = Card.new('7S')
    c2 = Card.new('8H')
    c3 = Card.new('TH')
    c4 = Card.new('AS')
    #same as c1
    c5 = Card.new('7S')
 
    assert_equal true, c1 == Card.new('7S')
    assert_equal true, c4 > c5
    assert_equal false, c2 > c2
    assert_equal true, c1 >= c5
    assert_equal true, c5 <= c1 
    assert_equal true, c5 == c1 
    assert_equal false, c5 > c4
  end 
   
  test "Shuffling " do
    a = Card.shuffle
    assert_equal 32, a.size
    
    #all diferent 
    a.each do |c| 
      brojac = 0 
      a.each do |b|
         if c == b 
           brojac = brojac + 1
         end 
      end
      # brojac must be 1
      assert_equal 1, brojac 
    end
     
  end
  
end
