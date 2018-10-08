class DataFormEntityResponseEmailUsersController < ApplicationController
  # before_action :set_kommunity
  before_action :access_allowed?, unless: :devise_controller?


  def email_details

  end


  def send_email

  end



end