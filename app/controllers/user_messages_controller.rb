class UserMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :access_allowed?


  def create
    @user_message = UserMessage.new(user_message_params)
    @user_message.user = current_user

    @user_message.save
  end


  # TODO, allow people to flag a discussion message (as soon as a set number of people flag a message, it gets hidden)
  # Yet to create database changes for it
  def def flag

  end


  private

  def user_message_params
    params.require(:user_message).permit(:content, :parent_type, :parent_id)
  end


end
