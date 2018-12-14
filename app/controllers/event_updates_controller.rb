class EventUpdatesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_event_update, only: [:destroy]
  before_action :access_allowed?



  def create
    @event_update = EventUpdate.create(event_id: Event.friendly.find(params[:event_id]).id, details: params[:event_update][:details], user_id: current_user.id)
  end


  def destroy
    # @eu_id = @event_update.id
    # @event_id = @event_update.event_id
    @event_update.destroy
  end


  private

  def event_update_params
    params.require(:event_update).permit(:details)
  end

  def set_event_update
    @event_update = EventUpdate.find(params[:id])
  end


end