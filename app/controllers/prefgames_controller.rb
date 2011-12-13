class PrefgamesController < ApplicationController
  def show
    @prefgame = Prefgame.new
  end
  def new
    @waiting = Waiting.new
    @waiting.save!
    game = Waiting.set_up_game 
    if game 
      render :text => "New Game"
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
