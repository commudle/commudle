class TrackSlotsController < ApplicationController
  before_action :authenticate_user!
  before_action :access_allowed?


  def create
    @track_slot = TrackSlot.new(track_slot_params)
    @track_slot.event_location_track_id = params[:event_location_track_id]
    @track_slot.save

  end


  def destroy
    @track_slot = TrackSlot.find(params[:id])

    @track_slot.destroy
  end


  def session_discussion
    # @session =

  end


  private

  def track_slot_params
    params[:track_slot][:start_time] = params[:track_slot][:start_time].to_datetime
    params[:track_slot][:end_time] = params[:track_slot][:end_time].to_datetime
    params.required(:track_slot).permit(:session_title, :start_time, :end_time, :speaker_registration_id)
  end

end