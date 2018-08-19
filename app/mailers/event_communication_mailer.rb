class EventCommunicationMailer < ApplicationMailer

  def rsvp_email(data_form_entity_response_group_id, subject, message)
    @dferg = DataFormEntityResponseGroup.includes(:user).find(data_form_entity_response_group_id )
    @message = message.html_safe

    mail(
        to: @dferg.user.email,
        subject: subject,
        template_path: "mailers/event_communication_mailer",
        template_name: "rsvp_email"
    )

  end


end
