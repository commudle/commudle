class CommentReplyMailerWorker
  @queue = :event_communication_emails

  def self.perform(user_id, comment_id, event_id)
    EventCommunicationMailer.comment_reply_email(User.find(user_id), Comment.find(comment_id), Event.find(event_id)).deliver_now
  end
end