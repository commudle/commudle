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



  def toggle_registration_form

    registration_form = @event.registration_form



    # check if there is an existing registration form assigned
    # if registration form is absent for the event, the mark this data form entity as registration form
    if registration_form.blank?
      @event.registration_form = @dfe
      @event.save
      @form_added = true
      @message = "Registration Form Assigned"
    else
    # if the registration form exists and is the same form, then remove it
      if registration_form == @dfe
        @event.registration_form = nil
        @event.save
        @form_added = false
        @message = "Registration Form Removed"

      else

        return error_response(
            ErrorNotification::ResponseTypes::JS,
            ErrorNotification::ErrorCodes::CONFLICT,
            "This event already has a registration form"
        )

      end


    end


  end


  private

  def set_data_form_entity
    @dfe = DataFormEntity.find_by(slug: params[:entity_id], entity: @event)
  end


end
