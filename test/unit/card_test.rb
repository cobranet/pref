require 'test_helper'

class CardTest < ActiveSupport::TestCase
   
   #initilisation tests
   test "Card string must be same as string argument" do
     cards = [ '7S', '8S', '9S', 'TS', 'JS', 'QS', 'KS', 'AS',
               '7D', '8D', '9D', 'TD', 'JD', 'QD', 'KD', 'AD',
               '7H', '8H', '9H', 'TH', 'JH', 'QH', 'KH', 'AH',
               '7C', '8C', '9C', 'TC', 'JC', 'QC', 'KC', 'AC']
               
     cards.each do |cstr|
       c = Card.new(cstr)
       assert_equal cstr , c.str
     end
   end
end
