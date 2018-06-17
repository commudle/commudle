class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]

  def index
    @events = Event.includes(kommunity: :user).where('kommunities.user_id = ?', current_user.id)
  end

  def show
  end


  def new

    @event = Event.new

  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to action: :index, notice: "Successfully created survey."
    else
      render :new
    end
  end


  def edit

  end

  def update

  end


  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :kommunity_id, :start_time, :end_time, :description)
  end
end
