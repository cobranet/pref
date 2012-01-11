class ScreenCard
  attr_reader :id, :x, :y, :str
  def initialize(id,x,y,str)
    @id = id
    @x = x
    @y = y
    @str = str
  end
end
# this is how particular player see the game
# he is ALLWAYS "south" but in real game he can'be east or west
# there is same methods as in game but with changed sits 
class Screen
  # Podrazumeva se da je ekran 640  x 320
  # a da su karte 50 x 80
  
  def initialize(game,player,users_ids)
    @game = game
    @seat = player # :east, :south , :west
    @user_ids = users_ids
    @table_width = 640
    @table_height = 320
  end


  def left
    if @seat ==  :south 
      return :east 
    elsif @seat == :east
      return :west
    else
      return :south 
    end              
  end


  def right
    if @seat ==  :south 
      return :west 
    elsif @seat == :east
      return :south
    else
      return :east 
    end              
  end
   
  def my_cards
    mc = Array.new
    @game.hand(@seat).each_with_index do |c,i|
      mc << ScreenCard.new(c.id,100+20*i,130,c.to_s)
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
