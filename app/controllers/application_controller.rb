class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include RolePermission

  before_action :set_time_zone



  before_action :set_kommunity
  before_action :access_allowed?, unless: :devise_controller?

  around_action :set_current_user

  helper_method :allowed_view?


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



  def organizer_logged_in?
    return current_user.organizer?(@kommunity.id)
  end



  protected
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end


  private


  def set_time_zone
    min = request.cookies["time_zone"].to_i
    Time.zone = ActiveSupport::TimeZone[-min.minutes]
  end

  def set_kommunity
    if (params[:kommunity])
      begin
        @kommunity = Kommunity.friendly.find(params[:kommunity])
        RolePermission.kommunity = @kommunity
      rescue
        puts(controller_name, action_name)
      end
    end

  end

  # def default_url_options(options={})
  #   if (!params[:kommunity].blank?)
  #     options.merge({:kommunity => params[:kommunity] })
  #
  #   end
  #
  #   return options
  # end






end
