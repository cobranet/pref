require 'test_helper'

class ScreenTest < ActiveSupport::TestCase
  test "On start my cards must have 10 entries" do
    g = Game.new
    sc = Screen.new(g,:south)
    assert_equal 10 , sc.my_cards.size
  end
end
