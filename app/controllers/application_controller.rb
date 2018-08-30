class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include RolePermission
  helper_method :allowed_view?

  around_action :set_current_user
  after_action :allowed?, unless: :devise_controller?

  def set_current_user
    CurrentAccess.user = current_user
    yield
  ensure
    # to address the thread variable leak issues in Puma/Thin webserver
    CurrentAccess.user = nil
  end


  def manual_user_authentication(user_id)
    sign_in(User.find(user_id), event: :authentication)
  end


  def error_response(response_type, error_code, message, data={})
    @message = message
    return render response_type, file: 'application/error_response', status: error_code
  end


  def set_kommunity
    @kommunity = Kommunity.friendly.find(params[:kommunity])
  end



  def organizer_logged_in?
    return current_user.organizer?(@kommunity.id)
  end


end
