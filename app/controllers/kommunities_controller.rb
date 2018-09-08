class KommunitiesController < ApplicationController


  def show
    @events = Event.where(kommunity_id: @kommunity_id)
  end
end