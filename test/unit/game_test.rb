require 'test_helper'

class GameTest < ActiveSupport::TestCase
  #setup
  def setup 
    pgame = Prefgame.find_by_id(1)
    # start;east;7S8STSASJDQDAD7CJCQH;9SQSKS8D9DTCQCACJHAH;JS7DTDKD8C9C7H8H9HTH;KHKC;XXXXXX;;;;END;
    @game1 = Game.from_game_string(pgame.game)
  end
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
  # test hand 1
  test "Create game from fixtures" do
    prefgame = Prefgame.find_by_id(1)
    g1 = Game.from_game_string(prefgame.game)
    assert_equal :east, g1.on_move
    east_hand = g1.hand(:east)
    west_hand = g1.hand(:west)
    south_hand = g1.hand(:south)
     
    assert_equal "JS", east_hand[0].to_s 
    assert_equal "7D", east_hand[1].to_s
   
    assert_equal "7S", west_hand[0].to_s 
    assert_equal "8S", west_hand[1].to_s
   
  end 
  # playable ?
  test "is_playable?" do
    # east is on move and any card from his hand is playable
    card = @game1.hand(:east)[0]
    assert_equal true, @game1.is_playable?(card)
  end 
  
  # left and right
  test "left and right player" do
    # in game 1 east is on move and his left is south and right is west
    assert_equal :east, @game1.on_move
    assert_equal :south, @game1.left(@game1.on_move)
    assert_equal :west, @game1.right(@game1.on_move)
  end 
  
  # who played first card in trick
  test "who played first card in trick" do
    #in game1 east is on move and there is no lead player yet....
    assert_equal nil, @game1.lead_player
  end

  # who has a card ? function player?
  test "who has a card " do
    assert_equal :west, @game1.player?(Card.new('JD'))
    assert_equal :east, @game1.player?(Card.new('TD'))    
    assert_equal :south, @game1.player?(Card.new('AC'))
    # KH is hiden ... must be nill
    assert_equal nil, @game1.player?(Card.new('KH'))
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
