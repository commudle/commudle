class RegistrationMailerWorker
  @queue = :event_communication_emails

  def self.perform(dfe_id, to_email, subject, message, event_details_options)
    dfe = DataFormEntity.find(dfe_id.to_i)
    if (to_email == 'ALL')
      # roles = UserRolesUser.includes(:user).joins(:user_role).where('user_roles.name = ? and kommunity_id', NameValues::UserRoleType::MEMBER, edfeg.event.kommunity_id)
      #
      # role.each do |roles|
      #   EventCommunicationMailer.registration_email(edfeg, subject, message, event_details_options, role.user).deliver_now
      # end

    else
      user = User.find_or_create(to_email)
      EventCommunicationMailer.registration_email(dfe, subject, message, event_details_options, user).deliver_now
    end

  end


end