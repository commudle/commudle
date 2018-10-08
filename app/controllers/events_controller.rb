class EventsController < ApplicationController
  # before_action :set_kommunity
  before_action :authenticate_user!, except: [:show]
  before_action :set_event, only: [:show, :edit, :update, :assign_data_form, :remove_data_form_entity, :update_event_status, :update_header_image, :all_responses]
  before_action :access_allowed?, unless: :devise_controller?



  def index
    @events = Event.includes(:kommunity, :event_data_form_entity_groups).joins(:kommunity).upcoming(kommunity_id: @kommunity.id)
    @event_location_track = EventLocationTrack.new
    @track_slot = TrackSlot.new
  end

  def show

    @event_statuses = EventStatus.all
    @event_location_track = EventLocationTrack.new
    @track_slot = TrackSlot.new
    @location = Location.new
    @new_comment = Comment.new

  end


  def new

    @event = Event.new

  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.timezone = ActiveSupport::TimeZone.all.collect{|z| z.tzinfo.name if z.utc_offset == event_params[:start_time].utc_offset}.compact![0]
    if @event.save
      redirect_to action: :show, id: @event
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


  def update_header_image
    # remove the existing header_image
    @event.header_image.attached? ? @event.header_image.purge : false
    @event.header_image.attach(params[:header_image])

  end


  def all_responses
    @all_response_groups = DataFormEntityResponseGroup.where('event_data_form_entity_groups.event_id = ?', @event.id).joins(:event_data_form_entity_group).includes(:user, event_data_form_entity_group: :event)

    @entry_passes = EventEntryPass.where(event_id: @event.id)

  end




  private

  def set_event
    @event = Event.includes(:user, event_data_form_entity_groups: {data_form_entities: :data_form}).find_by(slug: params[:id], kommunity_id: @kommunity.id)
    RolePermission.event = @event
  end

  def event_params
    params[:event][:start_time] = params[:event][:start_time].to_datetime
    params[:event][:end_time] = params[:event][:end_time].to_datetime
    params.require(:event).permit(:name, :kommunity_id, :start_time, :end_time, :description, :seats)
  end



end
