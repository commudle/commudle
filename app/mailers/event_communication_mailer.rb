class EventCommunicationMailer < ApplicationMailer

  default template_path: 'mailers/event_communication_mailer'

  def rsvp_email(data_form_entity_response_group, subject, message)
    @dferg = data_form_entity_response_group

    # create logs of the email sent
    fixed_email = FixedEmail.create(
                  mail_type: NameValues::FixedEmailType::RSVP,
                  subject: subject,
                  message: message
    )

    FixedEmailDfeResponseGroup.create(
                                  data_form_entity_response_group_id: @dferg.id,
                                  fixed_email_id: fixed_email.id
    )

    @message = message.html_safe

    mail(
        to: @dferg.user.email,
        subject: subject,
        # template_path: "mailers/event_communication_mailer",
        # template_name: "rsvp_email"
    )


  end


  def entry_pass_email(data_form_entity_response_group, subject, message)
    @dferg = data_form_entity_response_group
    # create logs of the email sent
    fixed_email = FixedEmail.create(
        mail_type: NameValues::FixedEmailType::ENTRY_PASS,
        subject: subject,
        message: message
    )

    FixedEmailDfeResponseGroup.create(
        data_form_entity_response_group_id: @dferg.id,
        fixed_email_id: fixed_email.id
    )

    mail(
        to: @dferg.user.email,
        subject: subject,
    )

  end


end
