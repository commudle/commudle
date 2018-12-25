module SessionDiscussionUpdate
  @queue = :discussion_messages_mails

  def self.perform
    DiscussionMessagesWorker.perform
  end

end
