class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :access_allowed?


  # a discussion should be created only when someone is logged in
  # TODO think about allowing people who didn't attend, to be able to create a discussion
  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user = current_user

    @discussion.save

    DiscussionFollower.find_or_create_by(user_id: current_user.id, discussion_id: @discussion.id)

    if (@discussion.parent_type == 'SpeakerResource')
      DiscussionFollower.find_or_create_by(user_id: @discussion.parent.user.id, discussion_id: @discussion.id)
    end

  end


  # TODO complete this part, only the organizer gets to see the hidden discussions
  def hide

  end


  private

  def discussion_params
    params.require(:discussion).permit(:parent_type, :parent_id, :topic, :description)
  end



end
