require 'test_helper'

class PrefgameTest < ActiveSupport::TestCase
  test "adding two" do
    pg = Prefgame.new
    pg.add_two
  end
end
