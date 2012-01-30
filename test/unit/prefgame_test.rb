require 'test_helper'

class PrefgameTest < ActiveSupport::TestCase
  def setup
    @users = Array.new
    (1..3).each do |i|
       @users << User.find_by_id(i).id
    end
    @pgame = Prefgame.create(@users)
  end
  
  test "creation of pref game" do 
    assert_not_equal nil, @pgame.id
    assert_equal String, @pgame.game.class
    assert_equal @pgame.east, 1
    assert_equal @pgame.south, 2
    assert_equal @pgame.west, 3
  end
   
  test "returning the screens" do
    @pgame.players.each do |user_id|
      screen = @pgame.screen(user_id)
      assert_equal 10, screen.my_cards.size
    end
  end 
  
  test "players in hand " do
    assert_equal 3,@pgame.players.size
    assert_equal 1,@pgame.players[0]
    assert_equal 2,@pgame.players[1]
    assert_equal 3,@pgame.players[2]
  end 
  
end
