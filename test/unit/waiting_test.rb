require 'test_helper'

class WaitingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "adding user in waiting list" do 
    Waiting.delete_all
    user = User.find_by_id(1)
    w = Waiting.new
    w.user_id = user.id
    w.save!
    pgame = Waiting.set_up_game
    assert_equal pgame, nil
  end 

  test "adding two users in waiting list" do 
    Waiting.delete_all
    user1 = User.find_by_id(1)
    user2 = User.find_by_id(2)
    
    w = Waiting.new
    w.user_id = user1.id
    w.save!

    w1 = Waiting.new
    w1.user_id = user2.id
    w1.save!
     
    pgame = Waiting.set_up_game
    
    assert_equal pgame, nil
    
  end
end
