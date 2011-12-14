require 'test_helper'

class GameTest < ActiveSupport::TestCase
  #initialization test
  test "New game" do
    g = Game.new

    #state must be :start 
    assert_equal :start, g.state

    #all hands must have 10 cards
    #taken must be 0 and played must be nil
    g.players.each do |player|
      assert_equal 10, g.hand(player).size
      assert_equal nil, g.played(player)
      assert_equal 0, g.taken(player)
      assert_equal "Starting the hand", g.player_message(player)
    end 
    
    #east is move
    assert_equal :east, g.on_move  

    
  end

  test "Test to_game_string" do
    g = Game.new
    assert_not_equal nil, g.to_game_string
    assert_equal 11, g.to_game_string.split(';').size
  end 
 
  test "From game string" do
    g = Game.new
    s = g.to_game_string
    puts Game.from_game_string(s)
  end
end
