class SpeakerResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_data_form_entity_response_group
  before_action :access_allowed?



  def new

  end


  def create
    return create_or_update_record
  end



  def update
    return create_or_update_record
  end



  private


  def set_data_form_entity_response_group

    @dferg = DataFormEntityResponseGroup.find_by_rsvp_token(params[:token]) || DataFormEntityResponseGroup.find_by_rsvp_token(params[:speaker_resource][:token])
    @spr = SpeakerResource.find_or_initialize_by(data_form_entity_response_group_id: @dferg.id)

  end



  def create_or_update_record
    # check if the current user is a speaker and dferg status is shortlisted or confirmed
    if @dferg.user == current_user && @dferg.registration_status?([NameValues::RegistrationStatusType::SHORTLISTED, NameValues::RegistrationStatusType::CONFIRMED]) && @dferg.event_data_form_entity_group.registration_type?([NameValues::RegistrationsType::SPEAKER])

      spr = SpeakerResource.find_or_create_by(data_form_entity_response_group_id: @dferg.id)

      spr.update(session_details_links: params[:speaker_resource][:session_details_links])

    else
      return error_response(
          ErrorNotification::ResponseTypes::JS,
          ErrorNotification::ErrorCodes::INVALID_INPUT,
          "This for is only for shortlisted speakers"
      )

    end

  end



end