# Class holding game date
# One hand of preferans
class Game
  #accessor 
  attr_reader :state, :on_move
  #initialze whith Card.shuffle or Hand
  def initialize(cards)
    #Game states
    @@STATES = [:start,
                :bidding, 
                :calling_trump ,
                :comming,
                :in_play,
                :score ]
    #dealer allways south
    #players
    @@PLAYERS = [:south,:west,:east]
    #while start waiting to east to start
    @state = :start
    #hand for each player
    @hands = {} 
    @hands[:south] = cards.slice(0,10)
    @hands[:east] = cards.slice(10,10)
    @hands[:west] = cards.slice(20,10)
    
    #cards played on table
    @played = {}
    @taken = {}
    @@PLAYERS.each do |player|
      @played[player] = nil
      @taken[player] = 0
    end      
    
    @on_move = :east 
  end
   
  #hand for player 
  def hand(player)
    @hands[player]
  end
 
  #players ring
  def players
    @@PLAYERS
  end

  #played ( card on table face up )
  def played(player) 
    @played[player]
  end

  #taken ( how much tricks player have )
  def taken(player)
    @taken[player]
  end

  #message for player explaing state
  def player_message(player)
    case @state
      when :start then  
        return "Starting the hand"
      else 
        return "TO STATE : #{@state}" 
    end
  end
end
