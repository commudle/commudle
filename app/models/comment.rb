class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable


  after_create :send_email_on_reply

  def event
    self.commentable_type == 'Event' ? self.commentable : self.commentable.commentable
  end


  def get_users_on_a_thread
    users = Set.new


    if self.commentable_type == 'Comment'
      users << self.commentable.user
      self.commentable.comments.each do |comment|
        users << comment.user
      end
    end

    return users.to_a

  end

  def send_email_on_reply
    if self.commentable_type == 'Comment'
      self.get_users_on_a_thread.each do |user|
        Resque.enqueue(CommentReplyMailerWorker, user.id, self.id, self.event.id)
      end
    end

  end

end
