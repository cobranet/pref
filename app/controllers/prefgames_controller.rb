#  create_table "prefgames", :force => true do |t|
#    t.string   "game"
#    t.string   "status"
#    t.integer  "east"
#    t.integer  "south"
#    t.integer  "west"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end


# Prefgame is database part of game ...
class PrefgamesController < ApplicationController

   before_filter :authenticate_user!

  def show
    @prefgame = Prefgame.find_by_id(params[:id])
  end


  #try to start new preferans game
  def new
    Waiting.add(current_user.id)
    @prefgame = Waiting.set_up_game
    if @prefgame 
      @prefgame.save! 
      render :action => "show" , :id => @prefgame.id
    else
      render :text => "Waiting"
    end
  end   


  #This triggered by user action
  def data 
    @prefgame = Prefgame.find_by_id(params[:id])
    @prefgame.players.each_with_index do |x,i|    
      gm = @prefgame.screen(@prefgame.players[i]).data
      user = User.find_by_id(@prefgame.players[i])
      if user == nil 
        raise RuntimeError , "There is no user with id #{@prefgame.players[i]} in game #{@prefgame.id}"
      end
      # call private  pub to dispach 
      PrivatePub.publish_to("/game/#{@prefgame.id}/#{user.id}", :gm => gm );
    end    
    render :nothing => true
  end
end
