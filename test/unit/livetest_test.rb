require 'test_helper'

class LivetestTest < ActiveSupport::TestCase
  def setup
    Livetest.create_two_users
  end
  test "adding two and one more " do
    Livetest.add_two
    user1 = User.find_by_id(1)
    Waiting.add(user1.id)
    pgame = Waiting.set_up_game
    pgame.save!
    assert_not_equal nil, pgame.id 
   end

end
