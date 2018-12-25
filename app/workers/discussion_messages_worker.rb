class DiscussionMessagesWorker
  @queue = :discussion_messages_mails

  # send an email for all the new messages to the speaker and the person who created the discussion
  # this email needs to be sent exactly at 11.59pm everyday for perfect functioning
  def self.perform
  #   get all the discussions which were created from the last time
  discussions = Discussion.where(created_at: Time.now.beginning_of_day..Time.now)

  #   get all the messages which were created from the last time
  messages = UserMessage.includes(:user).where(created_at: Time.now.beginning_of_day..Time.now, parent_type: "Discussion")


    all_discussion_ids = (discussions.map(&:id) + messages.map(&:parent_id)).uniq
  #   get all the discussion followers and send them an update about all these discussions updated
    DiscussionFollower.where(discussion_id: all_discussion_ids).group_by(&:user).each do |user, followers|
      discussions = Discussion.where(id: followers.map(&:discussion_id)).uniq
      EventCommunicationMailer.discussions_updated_email(user, discussions).deliver_now
    end



  end
end
