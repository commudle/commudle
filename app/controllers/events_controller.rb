class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :assign_data_form, :remove_data_form_entity]

  def index
    @events = Event.includes(kommunity: :user).joins(kommunity: :user).where('kommunities.user_id = ?', current_user.id)
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


  def assign_data_form
    data_form = DataForm.find_by(id: params[:data_form_id], kommunity_id: @event.kommunity_id)

    if data_form
      # if event already has a data form, then don't add, else add that data form, this just a safety measure to prevent duplicacy
      if @event.data_form_entities.where(data_form: data_form).blank?
        @dfe = DataFormEntity.new(entity: @event, data_form: data_form, name: data_form.name)
      else
        return error_response(ErrorNotification::ResponseTypes::JS, ErrorNotification::ErrorCodes::CONFLICT, "This form is already added to the event")
      end

      if (@dfe.save)

        respond_to do |format|

          format.js
        end


      end


    end


  end




  private

  def set_event
    @event = Event.includes(:user, data_form_entities: :data_form).friendly.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :kommunity_id, :start_time, :end_time, :description)
  end



end
