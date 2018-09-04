class EventsController < ApplicationController
  # before_action :set_kommunity
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :assign_data_form, :remove_data_form_entity, :update_event_status]


  def index
    @events = Event.includes(kommunity: :user).joins(kommunity: :user).where('kommunities.user_id = ?', current_user.id)
  end

  def show

    @event_statuses = EventStatus.all
    @event_location_track = EventLocationTrack.new
    @track_slot = TrackSlot.new

  end


  def new

    @event = Event.new

  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.timezone = ActiveSupport::TimeZone.all.collect{|z| z.tzinfo.name if z.utc_offset == event_params[:start_time].utc_offset}.compact![0]
    if @event.save
      redirect_to action: :show, id: @event.id
    else
      render :new
    end
  end


  def edit

  end

  def update
    @event.update_attributes(event_params)
    @event.timezone = ActiveSupport::TimeZone.all.collect{|z| z.tzinfo.name if z.utc_offset == event_params[:start_time].utc_offset}.compact![0]
    if @event.save
      redirect_to action: :show, kommunity: @event.kommunity, id: @event
    else
      render :edit
    end

  end



  def update_event_status
    @event.event_status = EventStatus.find(params[:event_status])
    @event.save

    @event_statuses = EventStatus.all


  end




  private

  def set_event
    @event = Event.includes(:user, event_data_form_entity_groups: {data_form_entities: :data_form}).find(params[:id])
    RolePermission.event = @event
  end

  def event_params
    params[:event][:start_time] = params[:event][:start_time].to_datetime
    params[:event][:end_time] = params[:event][:end_time].to_datetime
    params[:event][:timezone]
    params.require(:event).permit(:name, :kommunity_id, :start_time, :end_time, :description, :seats)
  end



end
