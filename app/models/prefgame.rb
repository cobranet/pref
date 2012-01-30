# create_table "prefgames", :force => true do |t|
# t.string "game"
# t.string "status"
# t.integer "east"
# t.integer "south"
# t.integer "west"
# t.datetime "created_at"
# t.datetime "updated_at"
# end
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
   
  # returning user ids of games
  def players
    @a = Array.new
    @a << east 
    @a << south
    @a << west
    @a
  end
   
  # no idea what is this sheet 
  def fgame
    if @full_game == nil
      @full_game = Game.from_game_string(self.game)
    end
    @full_game
  end

  #only synonm for id
  def game_id
    @id
  end

  # returning seat for user_id
  def player_seat(user_id)
    if east == user_id 
      return :east
    elsif south == user_id 
      return :south
    elsif west == user_id
      return :west
    else
      raise RuntimeError, "User : #{user_id} not in game #{@id}"
    end
  end 

  # returning data for user
  def screen(user_id)
    players = Array.new
    players << east
    players << south
    players << west
    screen = Screen.new(fgame,player_seat(user_id),players)
  end
   
end
