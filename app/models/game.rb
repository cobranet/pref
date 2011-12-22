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
      @taken[player] = Array.new
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
    @taken[player].size
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
  # Game is held in database as string 
  # delimitet by ; 
  # state;on_move;southcards;eastcards;westcards;holecards;tablecards;southtaken;ea  #  sttaken;westtaken
  # this is how game is putted in database
  def to_game_string
    s = "#{@state};"
    s = "#{s}#{@on_move};"
    @@PLAYERS.each do |player|
      @hands[player].each do |c|
        s = "#{s}#{c.to_s}"
      end
    s = "#{s};"
    end
    
    @hole_cards.each do |c|
      s = "#{s}#{c.to_s}"
    end
    s = "#{s};"
    
    @@PLAYERS.each do |p|
      if @played[p] 
        s = "#{s}#{@played[p]}"
      else
        s = "#{s}XX"
      end 
    end
    s = "#{s};"
    @@PLAYERS.each do |p|
      @taken[p].each do |c|
        s = "#{s}#{c.to_s}"
      end
    s = "#{s};"
    end
    s = "#{s}END;" 
    s
  end  
  # Game is held in database as string 
  # delimitet by ; 
  # state;on_move;southcards;eastcards;westcards;holecards;tablecards;southtaken;ea  #  sttaken;westtaken
  # 10 parts
  # this is how game is created from database
  def self.from_game_string(s)
    allocate.instance_eval do 
      game_arr = s.split(';')
      @state = game_arr[0]
      @on_move = game_arr[1]
      @hands = {}
      @@PLAYERS.each_with_index do |p,i|
        @hands[p] = Array.new 
        player_str = game_arr[2+i]
        (0..player_str.size/2-1).each do |s|
          @hands[p] << Card.new( player_str.slice(s*2,2))
        end
      end
      #there is allways two hole cards
      @hole_cards =  Array.new
      hole_str = game_arr[5]
      (0..1).each do |i|
        @hole_cards << Card.new(hole_str.slice(i*2,2)) 
      end

      #there is allways three table cards 
      #if XX then table cards is null
      @played = {}
      played_str = game_arr[6]
      @@PLAYERS.each_with_index do |p,i|
         card_str =  played_str.slice(i*2,2)
         if card_str == "XX" 
           @played[p] = nil
         else   
           @played[p] = Card.new()
         end
      end

      #taken 
      @taken = {}
      @@PLAYERS.each_with_index do |p,i|
        @taken[p] = Array.new
        taken_str = game_arr[7+i]
        (0..taken_str.size/2-1).each do |k|
          @taken[p] << Card.new(taken_str.slice(i*2,2))
        end
      end
    self
    end
  end
end
