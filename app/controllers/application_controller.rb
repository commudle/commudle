class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  around_action :set_current_user
  def set_current_user
    CurrentAccess.user = current_user
    yield
  ensure
    # to address the thread variable leak issues in Puma/Thin webserver
    CurrentAccess.user = nil
  end



  def hello_gdg

    return render html: "<strong>Welcome To GDG</strong>".html_safe
  end


  def error_response(response_type, error_code, message, data={})
    @message = message
    return render response_type, file: 'application/error_response', status: error_code
  end

end
