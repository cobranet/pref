# Class for holding one deal of preferans hand
# with inital setup many games can be played
class Hand < ActiveRecord::Base
  attr_accessor :cards
  
  # create new hand
  def create
    car = Card.shuffle
    car = Card.shuffle
    @cards = ""
    car.each do |c|
      @cards = "#{@cards}#{c.to_s}"
    end
  end

  # returning a array of Card 
  def get_cards
    a = Array.new
    (0..31).each do |i|
      a << Card.new(@cards.slice(i*2,2))
    end
    a
  end
end
