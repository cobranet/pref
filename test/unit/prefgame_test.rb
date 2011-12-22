require 'test_helper'

class PrefgameTest < ActiveSupport::TestCase
  def setup
    @users = Array.new
    (1..3).each do |i|
       @users << User.find_by_id(i).id
    end
  end
  
  test "creation of pref game" do 
    pgame = Prefgame.create(@users)
    assert_not_equal nil, pgame.id
    assert_equal String, pgame.game.class
    assert_equal pgame.east, 1
    assert_equal pgame.south, 2
    assert_equal pgame.west, 3
  end
   
  test "returning the screen" do
    pgame = Prefgame.create(@users)
    screen = pgame.screen(:east)
    assert_equal 10, screen.my_cards.size
  end 
end
