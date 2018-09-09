class FeedbackMailerWorker
  @queue = :event_communication_emails

  def self.perform(eep_id, form_id, subject, message)
    eep = EventEntryPass.find(eep_id)
    form = DataFormEntity.find(form_id)
    EventCommunicationMailer.feedback_email(eep, form, subject, message).deliver_now
  end


end