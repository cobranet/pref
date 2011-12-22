#  create_table "prefgames", :force => true do |t|
#    t.string   "game"
#    t.string   "status"
#    t.integer  "east"
#    t.integer  "south"
#    t.integer  "west"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
# Prefgames
class Prefgame < ActiveRecord::Base

  def self.create(players)
    p = Prefgame.new
    #create hand
    h = Hand.new
    h.create
    #create game
    @full_game = Game.new(h.get_cards)
    p.game = @full_game.to_game_string
    p.east = players[0]
    p.south = players[1]
    p.west = players[2]
    p.save!
    p
  end
  def fgame
    if @full_game == nil
      @full_game = Game.from_game_string(self.game)
    end
    @full_game
  end
  def game_id
    @id  
  end

  def screen(seat)
    players = Array.new
    players << east
    players << south
    players << west
    screen = Screen.new(fgame,seat,players)
  end
   
  def data 
    sc = screen(:south)
    sc.data
  end
   
end
