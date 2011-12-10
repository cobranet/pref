class PrefgamesController < ApplicationController
  def show
    @prefgame = Prefgame.new
  end
end
