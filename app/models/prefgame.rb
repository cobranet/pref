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
  # For testing purpose 
  # start new game with virtual players
  def add_two
    maka  = User.new( :email => 'marija.petrovic@gmail.com',
                      :password => '565675gfg' )
    maka.save!
    ana  = User.new( :email => 'ana.petrovic@gmail.com',
                     :password => 'fdsfdfs' )
    ana.save!
    Waiting.add(maka.id)
    Waiting.add(ana.id)
  end 
  
  def game_id
    @id  
  end

end
