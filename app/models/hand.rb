# Class for holding one deal of preferans hand
# with inital setup many games can be played
class Hand < ActiveRecord::Base
  attr_accessor :cards

  def create
    car = Card.shuffle
    @cards = ""
    car.each do |c|
      @cards = "#{@cards}#{c.to_s}"
    end
  end
end
