class EventCommunicationMailersController < ApplicationController
  # before_action :set_kommunity
  before_action :authenticate_user!
  before_action :set_event_details_options
  before_action :access_allowed?


  def registration_email
    @data_form_entity = DataFormEntity.find(params[:dfe])
    @edfeg = @data_form_entity.entity
    @event = @edfeg.event
    @registration_type = @edfeg.registration_type
  end

  def send_registration_email
    # Resque.enqueue(RegistrationMailerWorker, params[:dfe], params[:to], params[:subject], params[:message], @event_details_options)

    RegistrationMailerWorker.perform(params[:dfe], params[:to], params[:subject], params[:message], @event_details_options)
  end


  def data_form_entity_response_group_rsvp_email
    @dferg = DataFormEntityResponseGroup.includes(:user, event_data_form_entity_group: :event).find(params[:data_form_entity_response_group])
    @event = @dferg.event_data_form_entity_group.event
    @user = @dferg.user

  end


  def send_data_form_entity_response_group_rsvp_email
    DataFormEntityResponseGroup.send_rsvp_email([params[:id]], params[:subject], params[:message], true, @event_details_options)

  end


  def event_data_form_entity_group_rsvp_email
    @edfeg = EventDataFormEntityGroup.includes(:event).find(params[:event_data_form_entity_group])
    @event = @edfeg.event
    @force = params[:force].blank? ? false : params[:force]

  end


  def send_event_data_form_entity_group_rsvp_email
    edfeg = EventDataFormEntityGroup.includes(data_form_entity_response_groups: :user).find(params[:event_data_form_entity_group])
    DataFormEntityResponseGroup.send_rsvp_email(edfeg.data_form_entity_response_groups.joins(:registration_status).where('registration_statuses.name = ?', NameValues::RegistrationStatusType::SHORTLISTED).map(&:id), params[:subject], params[:message], (params[:force] == "true"), @event_details_options)

  end



  # entry_pass emails are sent only to registration_status confirmed
  def data_form_entity_response_group_entry_pass_email
    @dferg = DataFormEntityResponseGroup.includes(:user, event_data_form_entity_group: :event).find(params[:data_form_entity_response_group])
    @event = @dferg.event_data_form_entity_group.event
    @user = @dferg.user

  end

  def send_data_form_entity_response_group_entry_pass_email
    DataFormEntityResponseGroup.send_entry_pass_email([params[:data_form_entity_response_group]], params[:subject], params[:message], true, @event_details_options)
  end


  def event_data_form_entity_group_entry_pass_email
    @edfeg = EventDataFormEntityGroup.includes(:event).find(params[:event_data_form_entity_group])
    @event = @edfeg.event
    @force = params[:force].blank? ? false : params[:force]
  end


  def send_event_data_form_entity_group_entry_pass_email

    edfeg = EventDataFormEntityGroup.includes(data_form_entity_response_groups: :user).find(params[:event_data_form_entity_group])

    DataFormEntityResponseGroup.send_entry_pass_email(edfeg.data_form_entity_response_groups.joins(:registration_status).where('registration_statuses.name = ?', NameValues::RegistrationStatusType::CONFIRMED).map(&:id), params[:subject], params[:message], (params[:force] == "true"), @event_details_options)
  end


  # method to send feedback email to everyone
  def feedback_email
    @event = Event.friendly.find(params[:event])
    @form = DataFormEntity.find(params[:form])
    @force = params[:force].blank? ? false : params[:force]
  end



  def send_feedback_email
    event = Event.friendly.find(params[:event])
    @force = params[:force] == "true"
    event.send_feedback_emails(params[:form], params[:subject], params[:message], @force)
  end






  private

  def set_event_details_options
    @event_details_options = Hash.new
    @event_details_options[:event_description] = (params[:event_description] == '1' ? true : false)
    @event_details_options[:sessions_list] = (params[:sessions_list] == '1' ? true : false)
    @event_details_options[:timings] = (params[:timings] == '1' ? true : false)
    @event_details_options[:location] = (params[:location] == '1' ? true : false)

  end




end