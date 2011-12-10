# Class holding game date
# One hand of preferans
class Game
  #accessor 
  attr_reader :state, :on_move
  #initialze whith Card.shuffle or Hand
  def initialize
    cards = Card.shuffle
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
    @hands[:south] = cards.slice(0,10).sort!
    @hands[:east] = cards.slice(10,10).sort!
    @hands[:west] = cards.slice(20,10).sort!
    
    #cards played on table
    @played = {}
    # number of tricks taken by each player
    @taken = {}
    #sets taken and played
    @@PLAYERS.each do |player|
      @played[player] = nil
      @taken[player] = 0
    end      
    # hole cards    
    @hole_cards = cards.slice(30,2) 
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
  #hole cards 
  def hole
    @hole_cards
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

  #display hand 
  #helper to debug
  def display_game 
    @@PLAYERS.each do |player|
      puts player
      print "\t"
      hand(player).each do |card|
        print card
        print ' '
      end
      puts
    end
    @hole_cards.each do |card|
      print card 
      print ' '
    end
  end
  
end
