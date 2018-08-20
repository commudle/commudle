class EventCommunicationMailersController<ApplicationController
  before_action :authenticate_user!


  def data_form_entity_response_group_rsvp_email
    @dferg = DataFormEntityResponseGroup.includes(:user, event_data_form_entity_group: :event).find(params[:data_form_entity_response_group])
    @event = @dferg.event_data_form_entity_group.event
    @user = @dferg.user

  end



  def send_data_form_entity_response_group_rsvp_email

    DataFormEntityResponseGroup.send_rsvp_email([params[:id]], params[:subject], params[:message], true)

  end


  def event_data_form_entity_group_rsvp_email
    @edfeg = EventDataFormEntityGroup.includes(:event).find(params[:event_data_form_entity_group])
    @event = @edfeg.event
    @force = params[:force].blank? ? false : params[:force]

  end


  def send_event_data_form_entity_group_rsvp_email
    edfeg = EventDataFormEntityGroup.includes(data_form_entity_response_groups: :user).find(params[:event_data_form_entity_group])
    DataFormEntityResponseGroup.send_rsvp_email(edfeg.data_form_entity_response_groups.map(&:id), params[:subject], params[:message], (params[:force] == "true"))

  end



  # entry_pass emails are sent only to registration_status confirmed

  def send_data_form_entity_response_group_entry_pass_email

  end


  def send_data_form_entity_group_entry_pass_email

  end



end