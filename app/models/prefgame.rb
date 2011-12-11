class Prefgame < ActiveRecord::Base
  def initialize
    @game = Game.new
  end
  
  def game_id
    1
  end

end
