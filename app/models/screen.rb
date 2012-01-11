class ScreenCard
  attr_reader :id, :x, :y, :str
  def initialize(id,x,y,str,playable)
    @id = id
    @x = x
    @y = y
    @str = str
    @playable = playable
  end
end
# this is how particular player see the game
# he is ALLWAYS "south" but in real game he can'be east or west
# there is same methods as in game but with changed sits 
class Screen
  # Podrazumeva se da je ekran 640  x 400
  # a da su karte 50 x 80
  
  def initialize(game,player,users_ids)
    @game = game
    @seat = player # :east, :south , :west
    @user_ids = users_ids
    @table_width = 640
    @table_height = 400
  end

  # left player of screen player
  def left
    @game.left(@seat) 
  end

  #right player of screen player
  def right
    @game.right(@seat)
  end

  # cards for player screen
  def my_cards
    mc = Array.new
    @game.hand(@seat).each_with_index do |c,i|
      mc << ScreenCard.new(c.id,100+20*i,130,c.to_s,true)
    end 
    mc  
  end
  
  def data
    data = {
       :mycards => my_cards,
       :myname =>  'braca'
    }
    data.to_json
  end
end
