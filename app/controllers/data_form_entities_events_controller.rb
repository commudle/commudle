class DataFormEntitiesEventsController < EventsController
  before_action :authenticate_user!
  before_action :set_event, only: [:remove_data_form_entity, :toggle_registration_form, :toggle_speaker_form]
  before_action :set_data_form_entity, only: [:toggle_registration_form, :toggle_speaker_form]



  def remove_data_form_entity

    @dfe = DataFormEntity.find_by(slug: params[:entity_id], entity: @event)

    if (!@dfe.blank? && @dfe.data_form_entity_responses.length == 0 && @event.registration_form_id != @dfe.id)
      @dfe.destroy

    elsif (@event.registration_form_id == @dfe.id)
      return error_response(
          ErrorNotification::ResponseTypes::JS,
          ErrorNotification::ErrorCodes::INVALID_INPUT,
          "Registration forms cannot be deleted."
      )
    else


      return error_response(
          ErrorNotification::ResponseTypes::JS,
          ErrorNotification::ErrorCodes::INVALID_INPUT,
          "Cannot be deleted, it has form responses attached to it."
      )
    end


  end





  private

  def set_data_form_entity
    @dfe = DataFormEntity.find_by(slug: params[:entity_id], entity: @event)
  end


end
