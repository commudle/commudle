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
      redirect_to action: :index, notice: "Successfully created survey."
    else
      render :new
    end
  end


  def edit

  end

  def update
    @event.update_attributes(event_params)


    if @event.save
      redirect_to action: :index, notice: "Successfully created survey."
    else
      render :edit
    end

  end


  def assign_data_form
    data_form = DataForm.find_by(id: params[:data_form_id], kommunity_id: @event.kommunity_id)

    if data_form
      dfe = DataFormEntity.new(entity: @event, data_form: data_form)

      if (dfe.save)

        response.js {

        }

      end


    end
    response.js{

    }


  end

  def remove_data_form_entity
    dfe = DataFormEntity.find_by(id: params[:entity_id].to_i, entity: @event)

    if (!dfe.blank && dfe.form_responses.length == 0)
      dfe.destroy
    end

  end


  private

  def set_event
    @event = Event.includes(:user, data_form_entities: :data_form).find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :kommunity_id, :start_time, :end_time, :description)
  end
end
