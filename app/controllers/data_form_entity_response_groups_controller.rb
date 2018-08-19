class DataFormEntityResponseGroupsController<ApplicationController
  before_action :authenticate_user!, except: [:update_rsvp]
  before_action :set_data_form_entity_response_group, only: [:update_registration_status]


  # to be used by admin
  def update_registration_status
    @dfe_response_group.registration_status_id = params[:registration_status]

    @dfe_response_group.save


  end


  # rsvp changes the registration_status of response_group to confirmed, only if
  # the encrypted params must include registration_status and data_form_entity_response_group
  # can be done only if the RSVPs are still open on the event_data_form_entity_group
  def update_rsvp
    @dferg = DataFormEntityResponseGroup.find_by_rsvp_token(params[:token])
    rsvp_status = params[:rsvp_status]
    manual_user_authentication(@dferg.user_id)
    if(!@dferg.blank?)
      if(rsvp_status == "1" && @dferg.registration_status.name != "confirmed")
        @dferg.update(registration_status: RegistrationStatus.find_by_name(NameValues::RegistrationStatus::CONFIRMED))
      elsif(rsvp_status == "0" && @dferg.registration_status.name != "cancelled")
        @dferg.update(registration_status: RegistrationStatus.find_by_name(NameValues::RegistrationStatus::CANCELLED))
      end

    else
      return error_response(
          ErrorNotification::ResponseTypes::HTML,
          ErrorNotification::ErrorCodes::NOT_FOUND,
          "Welcome to the community! We're looking for the page you requested, someone will get back to you shortly!"
      )

    end



  end



  private


  def set_data_form_entity_response_group
    @dfe_response_group = DataFormEntityResponseGroup.find(params[:id])
  end


end