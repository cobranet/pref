# Class Card
# Playing card for Preferans
# there is 32 cards from 7 up from deck 
class Card

  @@VALUES = [ '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
  @@SUITS = ['S', 'D', 'H', 'C']

  # accepts string value+suit for example 7C , AH, TD
  def initialize(card_str)
    @suit = @@SUITS.index(card_str.slice(2,1)
    @value = @@VALUES.index(card_str.slice(1,1)
    unless @suit || @value raise ArgumentError, "Invalid card string #{card_str}!"
    @id = 8*@suit+value
    @str = card_str
  end
  
  #simply put @str
  def to_str
    @str
  end
end
