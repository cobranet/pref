require 'test_helper'

class WaitingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "adding user in waiting list" do 
    Waiting.delete_all
    user = User.find_by_id(1)
    Waiting.add(user.id)
    pgame = Waiting.set_up_game
    assert_equal pgame, nil
  end 

  test "adding two users in waiting list" do 
    Waiting.delete_all
    user1 = User.find_by_id(1)
    user2 = User.find_by_id(2)
    
    Waiting.add(user1.id)
    Waiting.add(user2.id) 
        
    pgame = Waiting.set_up_game
    
    assert_equal pgame, nil
  end

  test "adding three users ... set up game" do
    Waiting.delete_all
    user1 = User.find_by_id(1)
    user2 = User.find_by_id(2)
    user3 = User.find_by_id(3)
    Waiting.add(user1.id)
    Waiting.add(user2.id)
    Waiting.add(user3.id)
    pgame = Waiting.set_up_game
    assert_equal 1, pgame.game_id
  end
 
end
