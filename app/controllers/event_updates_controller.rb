class EventUpdatesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :access_allowed?



  def create

  end


  def destroy

  end


  private

  def event_update_params
    params.require(:event_update).permit(:details)
  end

  def set_event_update
    @event_update = EventUpdate.find(params[:event_update])
  end


end