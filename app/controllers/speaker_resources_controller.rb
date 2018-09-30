class SpeakerResourcesController < ApplicationController
  before_action :authenticate_user!


  def get_information

  end


  def create
    # check if the current user is a speaker and dferg status is shortlisted or confirmed
    if @dferg.user == current_user && @dferg.registrations_status?([NameValues::RegistrationStatusType::SHORTLISTED, NameValues::RegistrationStatusType::CONFIRMED] && @dferg.event_data_form_entity_group.registration_type?([NameValues::RegistrationsType::SPEAKER]))

      spr = SpeakerResource.find_or_create_by(data_form_entity_response_group_id: @dferg.id)

      spr.update(session_details_links: params[:session_details_links])

    else
      return error_response(
          ErrorNotification::ResponseTypes::JS,
          ErrorNotification::ErrorCodes::INVALID_INPUT,
          "This for is only for shortlisted speakers"
      )

    end





  end


  private


  def set_data_form_entity_response_group

    @dferg = DataFormEntityResponseGroup.find(params[:token])

  end



end