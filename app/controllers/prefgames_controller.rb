class PrefgamesController < ApplicationController

   before_filter :authenticate_user!

  def show
    @prefgame = Prefgame.new
  end
  #try to start new preferans game
  def new
    
    #for testing we first add two user 
    Waiting.add_two 
    Waiting.add(current_user.id)
    pgame = Waiting.set_up_game
    pgame.save! 
    if pgame 
      render :action => "show"
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
