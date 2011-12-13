class Prefgame < ActiveRecord::Base
  def initialize(players)
    @game = Game.new
  end
  
  def game_id
    1
  end

end
