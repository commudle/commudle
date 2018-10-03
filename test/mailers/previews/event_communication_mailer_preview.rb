# Preview all emails at http://localhost:3000/rails/mailers/event_communication_mailer
class EventCommunicationMailerPreview < ActionMailer::Preview

  def rsvp_email
    EventCommunicationMailer.rsvp_email(
        DataFormEntityResponseGroup.find(10),
        "What's Up Kommunity",
        "<p>lkjsfbvld</p>",
        {
          event_description: true,
          sessions_list: true,
          timings: true,
          location: true
        })
  end

  def entry_pass_email
    EventCommunicationMailer.entry_pass_email(
        DataFormEntityResponseGroup.first,
        "What's Up Kommunity",
        "<p>lkjsfbvld</p>",
        {
          event_description: true,
          sessions_list: true,
          timings: true,
          location: true
        })
  end


  def feedback_email
    EventCommunicationMailer.feedback_email(
        EventEntryPass.first,
        DataFormEntity.find(87),
        "Feedback",
        "<p>lkjsfbvld</p>"
    )
  end


  def comment_reply_email
    EventCommunicationMailer.comment_reply_email(
        User.first,
        Comment.first,
        Event.first
    )
  end

end
