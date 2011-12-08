# Class Card
# Playing card for Preferans
# there is 32 cards from 7 up from deck 
class Card

  #include modules
  include Comparable

  #class variabiles
  @@VALUES = [ '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
  @@SUITS = ['S', 'D', 'H', 'C']
  @@ALLCARDS = [ '7S', '8S', '9S', 'TS', 'JS', 'QS', 'KS', 'AS',
               '7D', '8D', '9D', 'TD', 'JD', 'QD', 'KD', 'AD',
               '7H', '8H', '9H', 'TH', 'JH', 'QH', 'KH', 'AH',
               '7C', '8C', '9C', 'TC', 'JC', 'QC', 'KC', 'AC']

  #attributes
  attr_reader :suit,:value,:id,:str
  
  # accepts string value+suit for example 7C , AH, TD
  def initialize(card_str)
    @suit = @@SUITS.index(card_str.slice(1,1))
    @value = @@VALUES.index(card_str.slice(0,1))
    @id = @@ALLCARDS.index(card_str)
    unless @id  
           raise  "Invalid card string #{card_str}!"
    end
    @str = card_str
  end
  
  #shuffling TODO improved later to get better randomes
  def self.shuffle
    a = Card.all_cards
    a.sort { rand }
  end
    
  # all cards
  def self.all_cards
    all = Array.new
    @@ALLCARDS.each do |s|
      all << Card.new(s)
    end
    all 
  end
  
  # .... simple if same suit
  def same_suit?(other)
    @suit == other.suit
  end

  #comparable, suits are ordered SDCH for visual separation
  def <=>(other)
    suit_order = [0,1,3,2]
    suit_compare = suit_order.index(@suit) == suit_order.index(other.suit)
    if suit_compare 
      return @value <=> other.value
    else
      return suit_compare
    end
  end  
 
  #to_str
  def to_s
    @str
  end
end
