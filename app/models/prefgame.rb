class Prefgame < ActiveRecord::Base
  attr_reader :players
  def self.create(players)
    p = Prefgame.new
    p.east = players[0]
    p.south = players[1]
    p.west = players[2]
    p.save
    p
  end  
  
  def game_id
    @id  
  end

end
