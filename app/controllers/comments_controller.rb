class CommentsController < ApplicationController
  before_action :set_parent
  before_action :access_allowed?


  def create

    @comment = Comment.create(body: params[:comment][:body], commentable: @commentable, user: current_user)

  end

  # to be used later
  def destroy

  end


  before_action

  def set_parent
    params[:id].blank? ? (@commentable = Comment.find(params[:comment_id])) : (@commentable = Event.friendly.find(params[:id]))
  end

end