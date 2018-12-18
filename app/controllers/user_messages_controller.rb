class UserMessagesController < ApplicationController
  before_action :authenticate_user
  before_action :access_allowed?


  def create

  end


  # TODO, allow people to flag a discussion message (as soon as a set number of people flag a message, it gets hidden)
  # Yet to create database changes for it
  def def flag

  end


end
