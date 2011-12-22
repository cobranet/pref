class LivetestsController < ApplicationController
  # on create add two virtal users
  def create
    Livetest.delete_virtual_users
    Livetest.create_two_users
    Livetest.add_two
    redirect_to  :root
  end
end
