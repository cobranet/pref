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
  attr_reader :bidding, :bid
  
  # bidding is array of bids
  # bid is string from @@BIDS
  def initialize(bidding,bid)
    if not @@BIDS.include?(bid) 
      raise RuntimeError, "Invalid bid #{bid}"
    end 
    @bidding = bidding
    @bid = bid
  end
end
