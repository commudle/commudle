class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :access_allowed?



  def create
    # TODO check if a location already exists, add it to the event
    @location = Location.create(location_params)


    @event.locations << @location
  end

  def destroy
    @location = Location.find(params[:id])

    if @event.locations.include? @location
      @event_location = @event.event_locations.find_by(location_id: @location.id)

      if (@event_location.user_event_locations.blank?)
        @event_location.destroy

      else
        return error_response(ErrorNotification::ResponseTypes::JS, ErrorNotification::ErrorCodes::UNAUTHORIZED, "Users have already chosen this location")


      end

    end
  end


  private
  def set_event
    @event = Event.friendly.find(params[:event_id])
  end

  def location_params
    params.require(:location).permit(:name, :address, :map_link)
  end


end