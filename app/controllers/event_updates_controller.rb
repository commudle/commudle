class EventUpdatesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_event_update, only: [:destroy]
  before_action :set_event, only: :create
  before_action :access_allowed?

  def create
    @event_update = @event.event_updates.create(event_update_params)
  end

  def destroy
    # @eu_id = @event_update.id
    # @event_id = @event_update.event_id
    @event_update.destroy
  end

  private

    def event_update_params
      _params = params.require(:event_update).permit(:details)
      _params.merge(user_id: current_user.id)
    end

    def set_event_update
      @event_update = EventUpdate.find(params[:id])
    end

    def set_event
      @event = Event.friendly.find(params[:event_id])
    end
end