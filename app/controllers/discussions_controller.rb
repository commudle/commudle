class DiscussionsController < ApplicationController
  before_action :authenticate_user
  before_action :access_allowed?


  # a discussion should be created only when someone is logged in
  # TODO think about allowing people who didn't attend, to be able to create a discussion
  def create

  end


  # TODO complete this part, only the organizer gets to see the hidden discussions
  def hide

  end



end
