class SpeakerResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_data_form_entity_response_group, except: [:session_discussions]
  before_action :access_allowed?



  def new

  end


  def create
    return create_or_update_record
  end



  def update
    return create_or_update_record
  end



  def session_discussions
    @resource = SpeakerResource.includes(:discussions, data_form_entity_response_group: [:user, event_data_form_entity_group: :event]).find(params[:speaker_resource])
    @discussion = Discussion.new

    @discussions = @resource.discussions

    # get the other sessions of this speaker
    @other_sessions = SpeakerResource.joins(:data_form_entity_response_group).where('speaker_resources.id != ? and data_form_entity_response_groups.user_id = ?', @resource.id, @resource.user.id)


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

      spr.update(title: params[:speaker_resource][:title], session_details_links: params[:speaker_resource][:session_details_links])

    else
      return error_response(
          ErrorNotification::ResponseTypes::JS,
          ErrorNotification::ErrorCodes::INVALID_INPUT,
          "This for is only for shortlisted speakers"
      )

    end

  end


end