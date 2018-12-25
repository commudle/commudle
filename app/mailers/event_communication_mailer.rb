class EventCommunicationMailer < ApplicationMailer

  default template_path: 'mailers/event_communication_mailer'


  # send out registration emails for either speaker or attendees (using the same template for now, subjects would be different)
  def registration_email(data_form_entity, subject, message, event_details_options = {}, user)
    fixed_email = FixedEmail.find_or_create_by(
                        mail_type: (data_form_entity.entity.registration_type.name == NameValues::RegistrationsType::SPEAKER ? NameValues::FixedEmailType::REGISTRATION_SPEAKER : NameValues::FixedEmailType::REGISTRATION_ATTENDEE),
                        subject: subject,
                        message: message
                  )

  #   Create a table: FixedEmailEdfeGroup and also save user_id in it
    fixed_email_edfeg = FixedEmailEdfeg.create(
                                           fixed_email: fixed_email,
                                           user: user,
                                           event_data_form_entity_group: data_form_entity.entity
    )


    @dfe = data_form_entity
    @edfeg = data_form_entity.entity
    @message = message.html_safe
    @event = data_form_entity.entity.event
    @event_details_options = event_details_options
    @user = user
    mail(
        to: @user.email,
        subject: subject,
    )

  end




  def rsvp_email(data_form_entity_response_group, subject, message, event_details_options = {})
    @dferg = data_form_entity_response_group

    # create logs of the email sent
    fixed_email = FixedEmail.find_or_create_by(
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
    @selected_location = UserEventLocation.user_selected_location(@dferg.user_id, @event.id)
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
    @selected_location = UserEventLocation.user_selected_location(@dferg.user_id, @event.id)
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
    @message = message
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



  def comment_reply_email(user, comment, event)
    @event = event
    @user = user
    @comment = comment
    @replying_user = @comment.user

    mail(
        to: @user.email,
        subject: "#{@event.name} :: #{@replying_user.name} :: New Comment"
    )
  end


  def discussions_updated_email(user, discussions)

    @user = user
    @discussions = discussions

    mail(
        to: @user.email,
        subject: 'Communities :: Discussion Updates On Sessions You Follow'
    )

  end


end
