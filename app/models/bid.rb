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
  end
   
  #someone is bidding
  def bid(bid)
    if @@BIDS.include?(bid) == false then
      raise RuntimeError, "Invalid bid #{bid}"
    end
    if bid == 'P' 
      @bids << bid
      return
    end
    if bid == "NB" 
      @bids << bid
      @last_bid = next_bid
      return
    end
  end 
  
  def next_bid
   if @last_bid == 'N'
     return '2'
   end   
   
   if @last_bid == '2' 
     return '3'
   end
   
   if @last_bid != '2' and @last_bid.slice(0,1) != "m"
     # we only add m (my) indetifer
     puts @last_bid
     return  "m#{@last_bid}"
   end
   
   if @last_bid.slice(0,1) == 'm' 
    return @@CONTRACTS[@@CONTRACTS.index(@last_bid.slice(1,1))+1]
   end 
     
  end 
     
end
