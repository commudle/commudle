class EventLocationTracksController < ApplicationController
  before_action :authenticate_user!

  def create

    @event_location_track = EventLocationTrack.new(event_location_track_params)
    @event_location_track.event_id = params[:id]

    @event_location_track.save

  end


  def destroy
    @event_location_track = EventLocationTrack.find(params[:id])
    @event_location_track.destroy
  end


  private

  def event_location_track_params
    params.require(:event_location_track).permit(:name)

  end

end