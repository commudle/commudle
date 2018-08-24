class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :assign_data_form, :remove_data_form_entity, :update_event_status]

  def index
    @events = Event.includes(kommunity: :user).joins(kommunity: :user).where('kommunities.user_id = ?', current_user.id)
  end

  def show

    @event_statuses = EventStatus.all
  end


  def new

    @event = Event.new

  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to action: :index
    else
      render :new
    end
  end


  def edit

  end

  def update
    @event.update_attributes(event_params)


    if @event.save
      redirect_to action: :index
    else
      render :edit
    end

  end



  def update_event_status
    @event.event_status = EventStatus.find(params[:event_status])

    @event.save

    return redirect_back fallback_location: root_path

  end




  private

  def set_event
    @event = Event.includes(:user, event_data_form_entity_groups: {data_form_entities: :data_form}).find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :kommunity_id, :start_time, :end_time, :description, :seats)
  end



end
