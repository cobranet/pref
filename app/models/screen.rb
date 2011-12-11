class ScreenCard
  attr_reader :img, :x, :y
  def initialize(img,x,y)
    @img = img
    @x = x
    @y = y
  end
end

class Screen
  # Podrazumeva se da je ekran 640  x 320
  # a da su karte 50 x 80
  
  def initialize(game,player)
    @game = game
    @player = player
    
    @table_width = 640
    @table_height = 320
  end
   
  def my_cards
    mc = Array.new
    @game.hand(@player).each_with_index do |c,i|
      mc << ScreenCard.new("#{c.to_s}.png",100+20*i,100)
    end 
    mc  
  end
  
  def data
    data = {
       :mycards => my_cards,
       :myname => 'Bratislav Petrovic'  
    }
    date.to_json
  end
  
end
