  # For testing purpose 
  # start new game with virtual players
class Livetest
  #deleting all users
  def self.delete_virtual_users    
    maka = User.find_by_email('marija.petrovic@gmail.com')
    ana = User.find_by_email('ana.petrovic@gmail.com')
    maka.destroy
    ana.destroy
  end
  # def create partners for tester
  def self.create_two_users
    maka  = User.new( :email => 'marija.petrovic@gmail.com',
                      :password => '565675gfg' )
    maka.save!
 
    ana  = User.new( :email => 'ana.petrovic@gmail.com',
                     :password => 'fdsfdfs' )
    ana.save!
 
  end
  # add two users for start game
  def self.add_two
    maka = User.find_by_email('marija.petrovic@gmail.com')
    ana = User.find_by_email('ana.petrovic@gmail.com')
    Waiting.add(maka.id)
    Waiting.add(ana.id)
  end 

end
