class EventCommunicationMailer < ApplicationMailer

  default template_path: 'mailers/event_communication_mailer'

  def rsvp_email(data_form_entity_response_group, subject, message, event_details_options = {})
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
    @event = @dferg.event_data_form_entity_group.event
    @event_details_options = event_details_options
    @user = @dferg.user
    mail(
        to: @dferg.user.email,
        subject: subject,
        # template_path: "mailers/event_communication_mailer",
        # template_name: "rsvp_email"
    )


  end


  def entry_pass_email(data_form_entity_response_group, subject, message, event_details_options = {})
    @dferg = data_form_entity_response_group
    @message = message
    @event = @dferg.event_data_form_entity_group.event
    @event_details_options = event_details_options
    @user = @dferg.user
    fixed_email = FixedEmail.find_or_create_by(
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


  def feedback_email(event_entry_pass, form, subject, message)

    @event_entry_pass = event_entry_pass
    @event = @event_entry_pass.event
    @form = form
    @user = @event_entry_pass.user
    fixed_email = FixedEmail.find_or_create_by(
        mail_type: NameValues::FixedEmailType::FEEDBACK,
        subject: subject,
        message: message
    )

    FixedEmailEventEntryPass.create(
        event_entry_pass: @event_entry_pass,
        fixed_email_id: fixed_email.id
    )

    mail(
        to: @event_entry_pass.user.email,
        subject: subject,
    )
  end


end
