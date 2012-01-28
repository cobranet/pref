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
    @prefgame = Prefgame.find_by_id(params[:id])
    @gm = @prefgame.data.to_json
    @gm = @prefgame.data 
    PrivatePub.publish_to("/messages/new", :gm => @gm );
    render :nothing => true
  end
end
