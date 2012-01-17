# Bid in preferans game 
class Bid
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
  @@BIDS = ['P','NB','G','GB','GS','D','RD']
  #bids description
  @@BIDS_DESC = [ 'pass',
                  'next bid',
                  'game',
                  'betl game',
                  'sans game',
                  'double',
                  'redouble' ]
  #main atributs bidding and bid
  attr_reader :bids, :last_bid
  
  #
  # bid is string from @@BIDS
  # last bid is minimal contract bidded
  # if bids are > '2' then can be bid twince ... in second we add indentifier m 
  # m3 , m4 .... m7
  def initialize
    @bids = Array.new
    @last_bid = 'N'
    @end = false
    @game_bidded = false 
    @doubled = false
    @redoubled = false
  end
   
  #someone is bidding
  def bid(bid)
    if bid_posible?(bid) == false 
      raise RuntimeError, "Invalid bid #{bid} last bid = #{@last_bid} game bided = #{@game_bidded} "
    end  
    # if game bidded
    if bid.slice(0,1) == 'G'
      @game_bidded = true
    end
    if bid == 'P' 
      @bids << bid
    elsif  bid == "NB" 
      @bids << bid
      @last_bid = next_bid
    end
    check_end
  end
  # check is bid posible 
  def bid_posible?(bid)
    if @@BIDS.include?(bid) == false
      return false
    end
    if @game_bidded and ( bid = 'NB' or bid = 'D' or bid = 'RD' )
      return false
    end 
    if @doubled == false and bid == 'RD'
      return false
    end
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
  # check is bidding is finish
  def check_end
    # after 3 pass bid it is end
    if @bids.slice(@bids.size-2,3).count("P") == 3 
      @end = true
    end
  end
  def is_end?
    @end
  end
       
end
