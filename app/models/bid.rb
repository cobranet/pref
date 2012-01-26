# Bid in preferans game 
class Bid
  #becouse dealer is always south ... first on bid is :east
  # posible contracts 
  @@CONTRACTS = ['N','2','3','4','5','6','7']
  #description of contracts 
  @@CON_DESC = ['none',
                'spade',
                'diamond',
                'hearts',
                'clubs',
                'betl',
                'sans' ]
  # bidds 
  # NB or next bid is minimal contract not bid yet
  @@BIDS = ['P','NB','G','GB','GS']
  #bids description
  @@BIDS_DESC = [ 'pass',
                  'next bid',
                  'game',
                  'betl game',
                  'sans game',
                  'double',
                  'redouble' ]
  #main atributs bidding and bid
  attr_reader :bids, :last_bid, :last_bidder
  
  #
  # bid is string from @@BIDS
  # last bid is minimal contract bidded
  # if bids are > '2' then can be bid twince ... in second we add indentifier m 
  # m3 , m4 .... m7
  def initialize
    @bidders = Array.new
    @bids = Array.new
    @last_bid = 'N'
    @last_bidder = nil
    @end = false
    @game_bidded = false 
    @more_bid_game = false
    @game_bidders = Array.new
    @pass_bidders = Array.new
    @game_contracts = Array.new
  end
     
  #someone is bidding
  def bid(bid)
    if bid_posible?(bid) == false 
      raise RuntimeError, "Invalid bid #{bid} last bid = #{@last_bid} game bided = #{@game_bidded} "
    end  
    # if game bidded
    if bid.slice(0,1) == 'G'
       if @game_bidded and bid == 'G' 
         @more_bid_game = true   
       end 
       @game_bidded = true
    end
    if bid == 'P' 
      nil
    elsif bid == 'NB' 
      @last_bid = next_bid
      @last_bidder = bidder
    else 
      @last_bid = bid
      @last_bidder = bidder
    end
    @bids << bid
    @bidders << bidder
    check_end
  end


  # check is bid posible
  # all bidding rules are here 
  def bid_posible?(bid)

    # if not in bid list can't be bidded 
    if @@BIDS.include?(bid) == false and @more_bid_game == false
      return false
    end
    # if no bids before anything can be bidded
    if @bids.size == 0 
      return true    
    end
     
    # if game bidded next bid is off
    if @game_bidded and bid == "NB"
      return false
    end
     
    # xsif sans game bid then can't call bettl
    if @last_bid == "GS" and bid == "GB"
      return false
    end

    #if sans game or betl  game bidded can't call game
    if @last_bid == 'GS' or @last_bid == 'GB' and bid == 'G' 
      return false
    end
    true
  end


  # next regular bid ( one up from last bid contract)
  def next_bid
   if @last_bid == 'N'
     return '2'
   end   
   
   if @last_bid == '2' 
     return '3'
   end
   
   if @last_bid != '2' and @last_bid.slice(0,1) != "m"
     # we only add m (my) indetifer
     return  "m#{@last_bid}"
   end
   
   if @last_bid.slice(0,1) == 'm' 
    return @@CONTRACTS[@@CONTRACTS.index(@last_bid.slice(1,1))+1]
   end 
     
  end 

  #all this methods is for this
  #returning array of possible bids
  def posible_bids
    a = Array.new
    @@BIDS.each do |bid|
      if bid_posible?(bid)
        a << bid
      end
    end    
    a
  end


  #who is bidder, everybody must bid ..or not ?
  #is there is rule that if you pass once can't bid later ?
  def next_player(player)
    
    if player == :east
      b = :west
    elsif player == :west
      b = :south
    else
      b = :east
    end 
    return b
  end  
  
  # this is missing from ruby .. I want index of nth element of array
  def self.nth_of_array (arr,value,n)
    how=0
    arr.each_with_index do |v,i|
      if v == value
        how = how+1
        if how == n 
          return i
        end
      end
    end
   nil
  end
  def bidder
    last = @bidders.last
    if @pass_bidders.include?(last) 
      @bids << 'P'
      @bidders <<  next_player(last)
      return bidder
    end
    next_player(last)     
  end
  
  
  


  # check is bidding is finish
  def check_end
    # after 3 pass bid it is end
    if @bids.size < 3
     return 
    end
    if @bids.slice(@bids.size-3,3).count("P") == 3  and @more_bid_game == false
      @end = true
    end
    if @bids.slice(@bids.size-2,2).count("P") == 2 and @more_bid_game == false  and @last_bidder == bidder 
      @end = true
    end
  end
  def is_end?
    @end
  end
       
end
