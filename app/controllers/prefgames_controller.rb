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
  #AJAX call this every X seconds ....
  def data 
    data = {
      :id =>  params[:id],
      :cards => [0,1,2,3,4,5,5] }
    render :text => data.to_json
  end
  
  
end
