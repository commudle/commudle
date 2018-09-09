class RsvpMailerWorker
  @queue = :event_communication_emails

  def self.perform(dferg_id, subject, message, event_details_options)
    dferg = DataFormEntityResponseGroup.find(dferg_id)
    EventCommunicationMailer.rsvp_email(dferg, subject, message, event_details_options).deliver_now
  end


end