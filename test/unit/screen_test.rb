require 'test_helper'

class ScreenTest < ActiveSupport::TestCase
  test "On start my cards must have 10 entries" do
    h = Hand.new
    h.create
    g = Game.new(h.get_cards)
    sc = Screen.new(g,:south,[1,2,3])
    assert_equal 10 , sc.my_cards.size
  end
end
