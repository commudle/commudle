class EventCommunicationMailersController<ApplicationController
  before_action :authenticate_user!



  def send_data_form_entity_response_group_rsvp_email

    EventCommunicationMailer.rsvp_email([params[:id]]).deliver_now

  end


  def send_data_form_entity_group_rsvp_email
    registration_status = params[:registration_status]

    dferg = DataFormEntityResponseGroup.joins(:data_form_entity_group).where(
        'data_form_entity_groups.id = ? and data_form_entity_response_groups.registration_status = ?',
        params[:id], params[:registration_status]
    )

    dferg_ids = dferg.map(&:id)

    EventCommunicationMailer.rsvp_email(dferg_ids).deliver_now

  end


end