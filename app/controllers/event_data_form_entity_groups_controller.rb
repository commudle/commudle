class EventDataFormEntityGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_event_data_form_entity_group, only: [:assign_data_form_entity, :destroy]


  def create

    if(@event.event_data_form_entity_groups.where(name: event_data_form_entity_groups_controller_params[:name]).blank?)
      @edfeg = EventDataFormEntityGroup.new(event_data_form_entity_groups_controller_params)
      @edfeg.event = @event
      @edfeg.user = current_user
      @edfeg.save
    else
      return error_response(ErrorNotification::ResponseTypes::JS, ErrorNotification::ErrorCodes::CONFLICT, "Form Set Names Should Be Unique")
    end
  end


  def destroy
  #   check if any responses are present in the EventDataFormEntityGroup
    existing_responses = DataFormEntityResponse.joins(:data_form_entity).where(
        "data_form_entities.entity_id = ? and data_form_entities.entity_type = ?",
        @edfeg, EventDataFormEntityGroup
    )

    if(!existing_responses.blank?)
      return error_response(ErrorNotification::ResponseTypes::JS, ErrorNotification::ErrorCodes::UNAUTHORIZED, "Cannot be deleted as it has responses")
    end

    @edfeg_id = @edfeg.id
    @edfeg.destroy
  end


  def assign_data_form_entity
    data_form = DataForm.find_by(id: params[:data_form_id], kommunity_id: @event.kommunity_id)

    if data_form
      # if event already has a data form, then don't add, else add that data form, this just a safety measure to prevent duplicacy
      if @edfeg.data_form_entities.where(data_form: data_form).blank?
        @dfe = DataFormEntity.new(entity: @edfeg, data_form: data_form, name: data_form.name)
        @dfe.save
      else
        return error_response(ErrorNotification::ResponseTypes::JS, ErrorNotification::ErrorCodes::CONFLICT, "This form is already added to the event")
      end



    end


  end



  private

  def set_event
    @event = Event.includes(:user, event_data_form_entity_groups: {data_form_entities: :data_form}).find(params[:id])
  end

  def set_event_data_form_entity_group
    @edfeg = EventDataFormEntityGroup.find(params[:event_data_form_entity_group_id])
  end

  def event_data_form_entity_groups_controller_params

    params.require(:event_data_form_entity_group).permit(:name, :registration_type_id)
  end


end