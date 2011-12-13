# Class waiting to set up the game 
# when player press the start game 
# he been added in Waiting list and if there
# is 3 player waiting then game is start
class Waiting < ActiveRecord::Base
  
  
  # call when new user is added
  def self.set_up_game
    prefgame = nil
    waitings = Waiting.find(:all)
    counter = 0
    for_game = Array.new
    waitings.each do |w| 
      counter = counter + 1
      for_game << w.user_id
        if counter == 3 
          prefgame = Prefgame.new(for_game)
          for_game.each do |user_id|
            w = Waiting.find_by_user_id(user_id)
            w.destroy   
        end     
      end
    end
    prefgame
  end
  
end
