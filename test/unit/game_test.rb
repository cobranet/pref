require 'test_helper'

class GameTest < ActiveSupport::TestCase
  #initialization test
  test "New game" do
    h = Hand.new
    h.create
     
    g = Game.new(h.get_cards)

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
  # create string to put in database with all game states
  test "Test to_game_string" do
    h = Hand.new
    h.create
    g = Game.new(h.get_cards)
    assert_not_equal nil, g.to_game_string
    assert_equal 11, g.to_game_string.split(';').size
  end 
  
  # testing loading game from string
  test "From game string" do
    h = Hand.new
    h.create
    g = Game.new(h.get_cards)
    s = g.to_game_string
    g1 = Game.from_game_string(s)
    assert_equal s, g1.to_game_string
  end
end
